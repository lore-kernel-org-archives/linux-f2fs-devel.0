From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: do checkpoint for the renamed inode
Date: Wed, 09 Jul 2014 10:59:18 +0800
Message-ID: <006301cf9b21$df8a42c0$9e9ec840$@samsung.com>
References: <1404297270-26809-1-git-send-email-jaegeuk@kernel.org>
	<006101cf9992$2a077340$7e1659c0$@samsung.com>
	<20140708063652.GB37622@jmac.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1X4i78-0008G2-8e
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Jul 2014 03:00:10 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1X4i75-0004eE-OE
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Jul 2014 03:00:10 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N8F00HWVCC0HX80@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Jul 2014 12:00:00 +0900 (KST)
In-reply-to: <20140708063652.GB37622@jmac.local>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, July 08, 2014 2:37 PM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: do checkpoint for the renamed inode
> 
> On Mon, Jul 07, 2014 at 11:17:35AM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Wednesday, July 02, 2014 6:35 PM
> > > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > linux-f2fs-devel@lists.sourceforge.net
> > > Cc: Jaegeuk Kim
> > > Subject: [f2fs-dev] [PATCH] f2fs: do checkpoint for the renamed inode
> > >
> > > If an inode is renamed, it should be registered as file_lost_pino to conduct
> > > checkpoint at f2fs_sync_file.
> > > Otherwise, the inode cannot be recovered due to no dent_mark in the following
> > > scenario.
> > >
> > > Note that, this scenario is from xfstests/322.
> > >
> > > 1. create "a"
> > > 2. fsync "a"
> > > 3. rename "a" to "b"
> > > 4. fsync "b"
> > > 5. Sudden power-cut
> > >
> > > After recovery is done, "b" should be seen.
> > > However, the result shows "a", since the recovery procedure does not enter
> > > recover_dentry due to no dent_mark.
> >
> > As we know CP is expensive, how about modifying checkpointed value directly
> > in nat cache at step #3? So "b" could be fsynced with dent_mark at step #4.
> 
> Yes, I also thought about that.
> But, when handling the nat cache, one of my concerns was the lock granularity.
> Basically each nat cache entry should be covered by its node page lock, so it
> is a little bit complicate to do something easily in f2fs_rename.
> 
> So, this patch was to fix the bug with a naive approach.
> And we can write additional patch to enhance this too.

Thanks for your explanation! :)

Regards,
Yu

> 
> Thanks,
> 
> >
> > >
> > > The reason is like below.
> > > - The nid of "a" is checkpointed during #2, f2fs_sync_file.
> > > - The inode page for "b" produced by #3 is written without dent_mark by
> > > sync_node_pages.
> > >
> > > So, this patch fixes this bug by assinging file_lost_pino to the "a"'s inode.
> > > If the pino is lost, f2fs_sync_file conducts checkpoint, and then recovers
> > > the latest pino and its dentry information for further recovery.
> > >
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/namei.c | 10 ++++------
> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > > index 96f1dd1..1b3cae0 100644
> > > --- a/fs/f2fs/namei.c
> > > +++ b/fs/f2fs/namei.c
> > > @@ -411,9 +411,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> > >  		}
> > >
> > >  		f2fs_set_link(new_dir, new_entry, new_page, old_inode);
> > > -		down_write(&F2FS_I(old_inode)->i_sem);
> > > -		F2FS_I(old_inode)->i_pino = new_dir->i_ino;
> > > -		up_write(&F2FS_I(old_inode)->i_sem);
> > >
> > >  		new_inode->i_ctime = CURRENT_TIME;
> > >  		down_write(&F2FS_I(new_inode)->i_sem);
> > > @@ -446,6 +443,10 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> > >  		}
> > >  	}
> > >
> > > +	down_write(&F2FS_I(old_inode)->i_sem);
> > > +	file_lost_pino(old_inode);
> > > +	up_write(&F2FS_I(old_inode)->i_sem);
> > > +
> > >  	old_inode->i_ctime = CURRENT_TIME;
> > >  	mark_inode_dirty(old_inode);
> > >
> > > @@ -455,9 +456,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> > >  		if (old_dir != new_dir) {
> > >  			f2fs_set_link(old_inode, old_dir_entry,
> > >  						old_dir_page, new_dir);
> > > -			down_write(&F2FS_I(old_inode)->i_sem);
> > > -			F2FS_I(old_inode)->i_pino = new_dir->i_ino;
> > > -			up_write(&F2FS_I(old_inode)->i_sem);
> > >  			update_inode_page(old_inode);
> > >  		} else {
> > >  			kunmap(old_dir_page);
> > > --
> > > 1.8.5.2 (Apple Git-48)
> > >
> > >
> > > ------------------------------------------------------------------------------
> > > Open source business process management suite built on Java and Eclipse
> > > Turn processes into business applications with Bonita BPM Community Edition
> > > Quickly connect people, data, and systems into organized workflows
> > > Winner of BOSSIE, CODIE, OW2 and Gartner awards
> > > http://p.sf.net/sfu/Bonitasoft
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> --
> Jaegeuk Kim


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
