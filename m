From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 1/3] generic: test project id recovery after
 power failure
Date: Sun, 7 Oct 2018 21:38:38 +0800
Message-ID: <20181007133838.GM17817@desktop>
References: <20181004043502.15005-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guaneryu@gmail.com>) id 1g99Go-0002RN-62
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Oct 2018 13:38:54 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1g99Gm-00DrtL-Ff
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Oct 2018 13:38:54 +0000
Received: by mail-pg1-f194.google.com with SMTP id 23-v6so6661390pgc.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 07 Oct 2018 06:38:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20181004043502.15005-1-chao@kernel.org>
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

On Thu, Oct 04, 2018 at 12:35:00PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> After fsync, filesystem should guarantee inode metadata including
> project id being persisted, so even after sudden power-cut, during
> mount, we should recover project_id fields correctly, in order to
> not loss those meta info.
> 
> So adding this testcase to check whether generic filesystem can
> guarantee that.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  tests/generic/506     | 97 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/506.out |  2 +
>  tests/generic/group   |  1 +
>  3 files changed, 100 insertions(+)
>  create mode 100644 tests/generic/506
>  create mode 100644 tests/generic/506.out
> 
> diff --git a/tests/generic/506 b/tests/generic/506
> new file mode 100644
> index 00000000..ca035a91
> --- /dev/null
> +++ b/tests/generic/506
> @@ -0,0 +1,97 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test 506
> +#
> +# This testcase is trying to test recovery flow of generic filesystem, w/ below
> +# steps, once project id changes, after we fsync that file, we can expect that
> +# project id can be recovered after sudden power-cuts.
> +# 1. touch testfile;
> +# 1.1 sync (optional)
> +# 2. chattr -p 100 testfile;
> +# 3. xfs_io -f testfile -c "fsync";
> +# 4. godown;
> +# 5. umount;
> +# 6. mount;
> +# 7. check project id
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
> +. ./common/quota
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

Better to add a new "LSATTR_PROG" entry as well in common/config and
_require_command "$LSATTR_PROG" lsattr

> +
> +_require_prjquota $SCRATCH_DEV
> +_require_scratch
> +_require_scratch_shutdown
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +
> +testfile=$SCRATCH_MNT/testfile
> +
> +do_check()
> +{
> +	_scratch_mount
> +
> +	touch $testfile
> +
> +	if [ "$1" == "sync" ]; then
> +		sync
> +	fi
> +
> +	chattr -p 100 $testfile

And use $CHATTR_PROG

> +
> +	before=`lsattr -p $testfile`

and $LSATTR_PROG in the test.

> +
> +	$XFS_IO_PROG -f $testfile -c "fsync" | _filter_xfs_io
> +
> +	_scratch_shutdown | tee -a $seqres.full
> +	_scratch_cycle_mount
> +
> +	after=`lsattr -p $testfile`
> +
> +	# check inode's uid/gid

Should be "project quota id"?

> +	if [ "$before" != "$after" ]; then
> +		echo "Before: $before"
> +		echo "After : $after"
> +	fi
> +	echo "Before: $before" >> $seqres.full
> +	echo "After : $after" >> $seqres.full
> +
> +	rm $testfile

rm -f $testfile

Thanks,
Eryu

> +	_scratch_unmount
> +}
> +
> +echo "Silence is golden"
> +
> +do_check
> +do_check sync
> +
> +status=0
> +exit
> diff --git a/tests/generic/506.out b/tests/generic/506.out
> new file mode 100644
> index 00000000..cb46b201
> --- /dev/null
> +++ b/tests/generic/506.out
> @@ -0,0 +1,2 @@
> +QA output created by 506
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 4da0e188..c7d42ff9 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -508,3 +508,4 @@
>  503 auto quick dax punch collapse zero
>  504 auto quick locks
>  505 shutdown auto quick metadata
> +506 shutdown auto quick metadata quota
> -- 
> 2.18.0
> 
