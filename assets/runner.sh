set -x

WORK1=${STOCKYARD}
WORK2=${WORK1/work/work2}
DONEFILE=${WORK2}/.rsync-work.done

# if DONEFILE doesnt exist OR force != 1
if [ ! -f "${DONEFILE}" ] || [ "${force_sync}" -eq "1" ]; then
    rm -f ${DONEFILE}; \
    time rsync --partial -azvv ${WORK1} ${WORK2} && \
    touch ${DONEFILE}; echo "Rsync of ${WORK1} to ${WORK2} complete" && \
    DATE=$(date '+%Y-%m-%d %H:%M:%S') && \
    echo "Rsync of ${WORK1} to ${WORK2} completed ${DATE}" | mail -s "Rsync report" ${user_email}
else
    echo "Rsync of ${WORK1} to ${WORK2} is already marked as complete. Re-run with 'force' to override."
fi

set +x
