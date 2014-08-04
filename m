From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 2/2] f2fs: invalidate xattr node page when
 evict inode
Date: Mon, 04 Aug 2014 09:42:44 +0800
Message-ID: <001c01cfaf85$80323940$8096abc0$@samsung.com>
References: <017301cfacc1$4b476730$e1d63590$@samsung.com>
	<20140802144223.GA1094@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XE7JP-00031h-Q8
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Aug 2014 01:43:43 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XE7JN-0001Iw-9t
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Aug 2014 01:43:43 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N9R00591E4LX240@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Aug 2014 10:43:33 +0900 (KST)
In-reply-to: <20140802144223.GA1094@jaegeuk-mac02.hsd1.ca.comcast.net>
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
> Sent: Saturday, August 02, 2014 10:42 PM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-fsdevel@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev][PATCH 2/2] f2fs: invalidate xattr node page when evict inode
> 
> Hi Chao,
> 
> On Thu, Jul 31, 2014 at 09:13:11PM +0800, Chao Yu wrote:
> > When inode is evicted, all the page cache belong to this inode should be
> > released including the xattr node page. But previously we didn't do this, this
> > patch fixed this issue.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/inode.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 0e69aa9..8a5403b 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -267,10 +267,16 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
> >  void f2fs_evict_inode(struct inode *inode)
> >  {
> >  	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
> > +	struct f2fs_inode_info *fi = F2FS_I(inode);
> >
> >  	trace_f2fs_evict_inode(inode);
> > +
> >  	truncate_inode_pages_final(&inode->i_data);
> >
> > +	if (fi->i_xattr_nid)
> > +		invalidate_mapping_pages(NODE_MAPPING(sbi),
> > +					fi->i_xattr_nid, fi->i_xattr_nid);
> 
> It would be good to place this below with invalidate_mapping_paages(ino).
> Since, in the case of deletion, we need to get the xattr node page again
> on the remove_inode_page call path.

Yes, IMO, it will be OK now when using above implementation because we will
invalidate this xattr page in truncate_node(), but I'd like use your method
because it's better to guarantee invalidating xattr page by evict_inode itself.

I will send a v2 patch, and thanks for your suggestion.

Regards,
Yu

> 
> Thanks,
> 
> > +
> >  	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
> >  			inode->i_ino == F2FS_META_INO(sbi))
> >  		goto out_clear;
> > --
> > 2.0.1.474.g72c7794


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
