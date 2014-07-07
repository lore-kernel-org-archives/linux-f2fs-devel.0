From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/2] f2fs: check name_len of dir entry to
 prevent from deadloop
Date: Mon, 07 Jul 2014 09:24:05 +0800
Message-ID: <005f01cf9982$4b8920f0$e29b62d0$@samsung.com>
References: <000001cf95b5$eac71ad0$c0555070$@samsung.com>
	<20140705064313.GA35795@jmac.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1X3xgK-0002AL-EN
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Jul 2014 01:25:24 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1X3xgG-0000FS-Pz
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Jul 2014 01:25:24 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N8B0018AIM1ED70@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Jul 2014 10:25:13 +0900 (KST)
In-reply-to: <20140705064313.GA35795@jmac.local>
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
> Sent: Saturday, July 05, 2014 2:43 PM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-fsdevel@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev][PATCH 1/2] f2fs: check name_len of dir entry to prevent from deadloop
> 
> Hi Chao,
> 
> On Wed, Jul 02, 2014 at 01:23:47PM +0800, Chao Yu wrote:
> > We assume that modification of some special application could result in zeroed
> > name_len, or it is consciously made by somebody. We will deadloop in
> > find_in_block when name_len of dir entry is zero.
> 
> Could you explain this a little bit more?
> I'm not sure how it can happen.

IMO,
On one hand, programs like mkfs/fsck/img2simg and f2fs could directly operate
the raw device, so bugs of these software may be triggered to generate the
corrupt data such as zeroed name_len.
On the other hand, it' could be treated as a potential security problem, because
user could crafted such a malicious image include zeroed name_len for hacking purpose.
Once such special image is being mounted, deadloop could be triggered, finally will
result in effecting on linux system's running.

Thanks,
Yu

> I think the zeroed name_len would cause some problems in f2fs_add_link.
> 
> Thanks,
> 
> >
> > This patch is added for preventing deadloop in above scenario.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/dir.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > index be8c7af..4316ec5 100644
> > --- a/fs/f2fs/dir.c
> > +++ b/fs/f2fs/dir.c
> > @@ -121,6 +121,16 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
> >  			}
> >  		}
> >
> > +		/* check name_len to prevent from deadloop here */
> > +		if (unlikely(de->name_len == 0)) {
> > +			struct inode *inode = dentry_page->mapping->host;
> > +
> > +			f2fs_msg(inode->i_sb, KERN_ERR,
> > +				"zero-length dir entry, ino = %lu, name = %s",
> > +				(unsigned long)inode->i_ino, name->name);
> > +			break;
> > +		}
> > +
> >  		bit_start = bit_pos
> >  				+ GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
> >  	}
> > --
> > 1.7.9.5
> 
> --
> Jaegeuk Kim


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
