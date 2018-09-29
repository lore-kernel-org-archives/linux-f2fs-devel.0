From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] generic: add a testcase to test uid/gid
 recovery
Date: Sat, 29 Sep 2018 13:56:56 +0800
Message-ID: <01a8d829-4dda-962a-9d9b-b7056f6b2166@huawei.com>
References: <20180925084558.77190-1-yuchao0@huawei.com>
 <20180928122622.GF17817@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1g68Fb-0001oK-F5
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Sep 2018 05:57:11 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g68FY-00DuP4-Rb
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Sep 2018 05:57:11 +0000
In-Reply-To: <20180928122622.GF17817@desktop>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/9/28 20:26, Eryu Guan wrote:
> On Tue, Sep 25, 2018 at 04:45:58PM +0800, Chao Yu wrote:
>> After fsync, filesystem should guarantee inode metadata including
>> uid/gid being persisted, so even after sudden power-cut, durign
>> mount, we should recover uid/gid fields correctly, in order to not
>> loss those meta info.
>>
>> So adding this testcase to check whether generic filesystem can
>> guarantee that.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> 
> Looks good to me. Just two minor issues inline, and I'll just fix them
> on commit.
> 
>> ---
>>  tests/generic/505     | 95 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/505.out |  2 +
>>  tests/generic/group   |  1 +
>>  3 files changed, 98 insertions(+)
>>  create mode 100755 tests/generic/505
>>  create mode 100644 tests/generic/505.out
>>
>> diff --git a/tests/generic/505 b/tests/generic/505
>> new file mode 100755
>> index 000000000000..103a1e9bbe47
>> --- /dev/null
>> +++ b/tests/generic/505
>> @@ -0,0 +1,95 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2018 Huawei.  All Rights Reserved.
>> +#
>> +# FS QA Test 505
>> +#
>> +# This testcase is trying to test recovery flow of generic filesystem, w/ below
>> +# steps, once uid or gid changes, after we fsync that file, we can expect that
>> +# uid/gid can be recovered after sudden power-cuts.
>> +# 1. touch testfile;
>> +# 1.1 sync (optional)
>> +# 2. chown 100 testfile;
>> +# 3. chgrp 100 testfile;
>> +# 4. xfs_io -f testfile -c "fsync";
>> +# 5. godown;
>> +# 6. umount;
>> +# 7. mount;
>> +# 8. check uid/gid
>> +#
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +_supported_fs generic
>> +_supported_os Linux
>> +
>> +_require_scratch
>> +_require_scratch_shutdown
>> +
>> +_scratch_mkfs >/dev/null 2>&1
>> +_require_metadata_journaling $SCRATCH_DEV
>> +
>> +testfile=$SCRATCH_MNT/testfile
>> +stat_opt='-c "uid: %u, gid: %g"'
>> +
>> +_do_check()
> 
> Name local functions without the leading underscore, which usually
> indicates it's a global helper function.

Okay.

> 
>> +{
>> +	_scratch_mount
>> +
>> +	touch $testfile
>> +
>> +	if [ "$1" == "sync" ]; then
>> +		sync
>> +	fi
>> +
>> +	chown 100 $testfile
>> +	chgrp 100 $testfile
>> +
>> +	before=`stat "$stat_opt" $testfile`
>> +
>> +	$XFS_IO_PROG -f $testfile -c "fsync" | _filter_xfs_io
>> +
>> +	_scratch_shutdown | tee -a $seqres.full
>> +	_scratch_unmount
>> +	_scratch_mount
> 
> _scratch_cycle_mount

Yes, that's more clean, thanks. :)

Thanks,

> 
> Thanks,
> Eryu
> 
>> +
>> +	after=`stat "$stat_opt" $testfile`
>> +
>> +	# check inode's uid/gid
>> +	if [ "$before" != "$after" ]; then
>> +		echo "Before: $before"
>> +		echo "After : $after"
>> +	fi
>> +	echo "Before: $before" >> $seqres.full
>> +	echo "After : $after" >> $seqres.full
>> +
>> +	rm $testfile
>> +	_scratch_unmount
>> +}
>> +
>> +_do_check
>> +_do_check sync
>> +
>> +status=0
>> +echo "Silence is golden"
>> +exit
>> diff --git a/tests/generic/505.out b/tests/generic/505.out
>> new file mode 100644
>> index 000000000000..80e3bd1d9abb
>> --- /dev/null
>> +++ b/tests/generic/505.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 505
>> +Silence is golden
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 55155de8bc29..4da0e1888f57 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -507,3 +507,4 @@
>>  502 auto quick log
>>  503 auto quick dax punch collapse zero
>>  504 auto quick locks
>> +505 shutdown auto quick metadata
>> -- 
>> 2.18.0.rc1
>>
> 
> .
> 
