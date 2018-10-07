From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 2/3] generic: test i_flags recovery after
 power failure
Date: Sun, 7 Oct 2018 21:47:48 +0800
Message-ID: <20181007134748.GN17817@desktop>
References: <20181004043502.15005-1-chao@kernel.org>
 <20181004043502.15005-2-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guaneryu@gmail.com>) id 1g99Pf-0002ah-O0
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Oct 2018 13:48:03 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1g99Pd-00Ds5o-JY
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Oct 2018 13:48:03 +0000
Received: by mail-pg1-f194.google.com with SMTP id f18-v6so6682306pgv.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 07 Oct 2018 06:48:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20181004043502.15005-2-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Oct 04, 2018 at 12:35:01PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> After fsync, filesystem should guarantee inode metadata including
> i_flags being persisted, so even after sudden power-cut, during
> mount, we should recover i_flags fields correctly, in order to not
> loss those meta info.
> 
> So adding this testcase to check whether generic filesystem can
> guarantee that.
> 
> We only check below attribute modification which most filesystem
> supports:
> - no atime updates (A)
> - secure deletion (s)
> - synchronous updates (S)
> - undeletable (u)
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  tests/generic/507     | 132 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/507.out |   2 +
>  tests/generic/group   |   1 +
>  3 files changed, 135 insertions(+)
>  create mode 100755 tests/generic/507
>  create mode 100644 tests/generic/507.out
> 
> diff --git a/tests/generic/507 b/tests/generic/507
> new file mode 100755
> index 00000000..2c718f8d
> --- /dev/null
> +++ b/tests/generic/507
> @@ -0,0 +1,132 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test 507
> +#
> +# This testcase is trying to test recovery flow of generic filesystem, w/ below
> +# steps, once i_flags changes, after we fsync that file, we can expect that
> +# i_flags can be recovered after sudden power-cuts.
> +# 1. touch testfile;
> +# 1.1 sync (optional)
> +# 2. chattr +[AsSu] testfile
> +# 3. xfs_io -f testfile -c "fsync";
> +# 4. godown;
> +# 5. umount;
> +# 6. mount;
> +# 7. check i_flags
> +# 8. chattr -[AsSu] testfile
> +# 9. xfs_io -f testfile -c "fsync";
> +# 10. godown;
> +# 11. umount;
> +# 12. mount;
> +# 13. check i_flags
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +
> +_require_test_lsattr
> +_require_command "$CHATTR_PROG" chattr

Need to check if the "$opt" is supported by the filesystem, i.e.

_require_chattr AsSu

Currently xfs doesn't support changing attr 's' and 'u' so test fails.

> +
> +_require_scratch
> +_require_scratch_shutdown
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +
> +testfile=$SCRATCH_MNT/testfile
> +opt="AsSu"
> +
> +do_check()
> +{
> +	attr=$1
> +
> +	_scratch_mount
> +
> +	touch $testfile
> +
> +	if [ "$2" == "sync" ]; then
> +		echo "sync" >> $seqres.full
> +		sync
> +	fi
> +
> +	echo "Test chattr +$1" >> $seqres.full
> +
> +	# add attribute
> +	chattr +$attr $testfile

$CHATTR_PROG

> +
> +	before=`lsattr $testfile`

$LSATTR_PROG (after adding the definition in patch 1).

> +
> +	$XFS_IO_PROG -f $testfile -c "fsync" | _filter_xfs_io
> +
> +	_scratch_shutdown | tee -a $seqres.full
> +	_scratch_cycle_mount
> +
> +	after=`lsattr $testfile`
> +
> +	# check inode's i_flags
> +	if [ "$before" != "$after" ]; then
> +		echo "Before: $before"
> +		echo "After : $after"
> +	fi
> +	echo "Before: $before" >> $seqres.full
> +	echo "After : $after" >> $seqres.full
> +
> +	echo "Test chattr -$1" >> $seqres.full
> +
> +	# delete attribute
> +	chattr -$attr $testfile
> +
> +	before=`lsattr $testfile`
> +
> +	$XFS_IO_PROG -f $testfile -c "fsync" | _filter_xfs_io
> +
> +	_scratch_shutdown | tee -a $seqres.full
> +	_scratch_cycle_mount
> +
> +	after=`lsattr $testfile`
> +
> +	# check inode's i_flags
> +	if [ "$before" != "$after" ]; then
> +		echo "Before: $before"
> +		echo "After : $after"
> +	fi
> +	echo "Before: $before" >> $seqres.full
> +	echo "After : $after" >> $seqres.full
> +
> +	rm $testfile

rm -f $testfile

> +	_scratch_unmount
> +}
> +
> +echo "Silence is golden"
> +
> +for i in `seq ${#opt}`; do
> +	do_check ${opt:$i-1:1}
> +	do_check ${opt:$i-1:1} sync
> +done

I think it'd be easier to read if we do something like:

opts="A s S u"
for i in $opts; do
	do_check $i
	do_check $i sync
done

Thanks,
Eryu

> +
> +status=0
> +exit
> diff --git a/tests/generic/507.out b/tests/generic/507.out
> new file mode 100644
> index 00000000..3d8672f8
> --- /dev/null
> +++ b/tests/generic/507.out
> @@ -0,0 +1,2 @@
> +QA output created by 507
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index c7d42ff9..e94253dc 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -509,3 +509,4 @@
>  504 auto quick locks
>  505 shutdown auto quick metadata
>  506 shutdown auto quick metadata quota
> +507 shutdown auto quick metadata
> -- 
> 2.18.0
> 
