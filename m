From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/7] f2fs: use IS_ENCRYPTED() to check
 encryption status
Date: Fri, 30 Nov 2018 10:57:58 +0530
Message-ID: <2639396.LW90XSOufJ@localhost.localdomain>
References: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
 <2911123.OYxvaggYeN@localhost.localdomain>
 <20181129190512.GB168705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1gSbLW-00030t-Co
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Nov 2018 05:28:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gSbLU-00Ar7C-Fn
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Nov 2018 05:28:10 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAU5ISCm046889
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 30 Nov 2018 00:28:00 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p2x3jt0db-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 30 Nov 2018 00:28:00 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Fri, 30 Nov 2018 05:27:58 -0000
In-Reply-To: <20181129190512.GB168705@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net

On Friday, November 30, 2018 12:35:13 AM IST Eric Biggers wrote:
> Hi Chandan,
> 
> On Thu, Nov 29, 2018 at 04:08:31PM +0530, Chandan Rajendra wrote:
> > On Monday, November 26, 2018 11:04:35 PM IST Theodore Y. Ts'o wrote:
> > > On Sun, Nov 25, 2018 at 11:00:38PM -0500, Theodore Y. Ts'o wrote:
> > > > 
> > > > It might be that the simplest way to solve things is to merge the f2fs
> > > > dev branch up to 79c66e75720c.  This will have the net effect of
> > > > including the five patches listed above onto the fscrypt git tree.  So
> > > > long you don't plan to rebase or otherwise change these five patches,
> > > > it should avoid any merge conflicts.
> > > 
> > > I've set up a git branch which has the f2fs dev branch, 4.20-rc4, the
> > > fsverity patches, and part of Chandan's patch series here:
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/tytso/fscrypt.git test-working
> > > 
> > > There is a minor conflict when I did a trial merge with f2fs.git's dev
> > > branch, but it's pretty obvious to how to resolve it.
> > > 
> > > Jaegeuk, Eric, Chandan, please take a look and let me know what you
> > > think.
> > 
> > Ted,
> > 
> > I have addressed the review comments provided by Eric. Hence three out of
> > the four patches in the test-working branch have new changes. I also got
> > UBIFS to use CONFIG_FS_ENCRYPTION instead of the per-filesystem config
> > symbol.
> > 
> > I am currently executing fstests to verify the changes.
> > 
> > 
> > Eric,
> > 
> > When executing generic/900, I noticed that sometimes xfs_io would get stuck
> > for an indefinite period. /proc/<pid of xfs_io>/stack showed that the task was
> > stuck in tty_read() inside the kernel. The following change fixed it,
> > 
> > diff --git a/tests/generic/900 b/tests/generic/900
> > index 290889ce..0831eed4 100755
> > --- a/tests/generic/900
> > +++ b/tests/generic/900
> > @@ -83,7 +83,7 @@ _fsv_create_enable_file $fsv_file >> $seqres.full
> >  echo "* reading"
> >  $XFS_IO_PROG -r $fsv_file -c ''
> >  echo "* xfs_io writing, should be O_RDWR"
> > -$XFS_IO_PROG $fsv_file |& _filter_scratch
> > +$XFS_IO_PROG -c '' $fsv_file 2>&1 | _filter_scratch
> >  echo "* bash >>, should be O_APPEND"
> >  bash -c "echo >> $fsv_file" |& _filter_scratch
> >  echo "* bash >, should be O_WRONLY|O_CREAT|O_TRUNC"
> > 
> > xfs_io gets into interactive mode when invoked without a "-c cmd" string.
> > 
> > However, I am not able recreate the scenario once again without the above
> > changes applied. I am not sure about what changed. 
> > 
> 
> The test is opening a verity file for read+write access, which should fail.  But
> it's incorrectly succeeding, hence the test is right to not pass.  Did you add
> the missing call to ext4_set_inode_flags() in ext4_set_verity() as I
> suggested?
> 
> (But I'll make the suggested change to the test too, so it fails cleanly in this
> case rather than hangs reading from stdin.)

Yes, I did make the suggested changes. But the test would some times hang
indefinitely because of xfs_io waiting on input from stdin.

With the new changes made to ext4_set_verity(), I see that the fsck fails
consistency check. But the failure is seen even without my patches applied. I
have planned to debug the failure after I post the next version of the
patchset.

-- 
chandan
