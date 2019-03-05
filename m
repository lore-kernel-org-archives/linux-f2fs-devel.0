From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic: test i_mode recovery after power
 failure
Date: Wed, 6 Mar 2019 07:53:44 +1100
Message-ID: <20190305205344.GC26298@dastard>
References: <20190305114744.129633-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <david@fromorbit.com>) id 1h1H4X-00040q-CY
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Mar 2019 20:53:57 +0000
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1h1H4V-005ehM-66
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Mar 2019 20:53:57 +0000
Content-Disposition: inline
In-Reply-To: <20190305114744.129633-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: guaneryu@gmail.com, fdmanana@gmail.com, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, Mar 05, 2019 at 07:47:44PM +0800, Chao Yu wrote:
> After fsync, filesystem should guarantee inode metadata including
> permission info being persisted, so even after sudden power-cut,
> during mount, we should recover i_mode fields correctly, in order
> to not loss those meta info.
> 
> So adding this testcase to check whether generic filesystem can
> guarantee that.

Can I make a suggestion here?

I've noticed that we are getting a lot of these one-off, random
"fsync persists one specific piece of metadata in one specific case"
tests, mainly in response to some fsync bug that was found in btrfs.
This is reactive, and does not find new bugs in this area.

We are also beyond the point where the number of tests is
maintainable (e.g. to be able to make infrastructure changes), so we
really should be looking to consolidate largely similar tests into
single tests where possible.

I'd strongly suggest that a robust fsync tester should be written
for all the cases that are currently being addressed in an ad hoc
fashion. Then they can be consolidated into a single test run, and
we can get rid of all the one-off "fsync failed on this <specific
thing>" tests from the harness.

Oh, wait, we *already have that infrastructure*: src/fsync-tester.c
and generic/311.

Can we please consider rolling all of these "do something, fsync,
drop-writes, remount check" into fsync-tester.c and do the same for
all future one-off "did fsync persist X" tests?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
