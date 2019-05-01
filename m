From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [PATCH V2 03/13] fsverity: Add call back to decide
 if verity check has to be performed
Date: Wed, 01 May 2019 18:03:56 +0530
Message-ID: <1679959.ODoryAfBfi@localhost.localdomain>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
 <20190428043121.30925-4-chandan@linux.ibm.com>
 <20190430211037.GA30337@azazel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hLqAA-0001SR-V3
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 May 2019 14:24:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hLqA8-002BLX-PN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 May 2019 14:24:46 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x41EMHJF112006
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 1 May 2019 10:24:39 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s78uks0aw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 01 May 2019 10:24:38 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Wed, 1 May 2019 15:24:36 +0100
In-Reply-To: <20190430211037.GA30337@azazel.net>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jeremy Sowden <jeremy@azazel.net>
Cc: hch@infradead.org, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org

On Wednesday, May 1, 2019 2:40:38 AM IST Jeremy Sowden wrote:
> On 2019-04-28, at 10:01:11 +0530, Chandan Rajendra wrote:
> > Ext4 and F2FS store verity metadata in data extents (beyond
> > inode->i_size) associated with a file. But other filesystems might
> > choose alternative means to store verity metadata. Hence this commit
> > adds a callback function pointer to 'struct fsverity_operations' to
> > help in deciding if verity operation needs to performed against a
> > page-cache page holding file data.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > ---
> >  fs/ext4/super.c          | 6 ++++++
> >  fs/f2fs/super.c          | 6 ++++++
> >  fs/read_callbacks.c      | 4 +++-
> >  include/linux/fsverity.h | 1 +
> >  4 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index aba724f82cc3..63d73b360f1d 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1428,10 +1428,16 @@ static struct page *ext4_read_verity_metadata_page(struct inode *inode,
> >  	return read_mapping_page(inode->i_mapping, index, NULL);
> >  }
> >  
> > +static bool ext4_verity_required(struct inode *inode, pgoff_t index)
> > +{
> > +	return index < (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +}
> > +
> >  static const struct fsverity_operations ext4_verityops = {
> >  	.set_verity		= ext4_set_verity,
> >  	.get_metadata_end	= ext4_get_verity_metadata_end,
> >  	.read_metadata_page	= ext4_read_verity_metadata_page,
> > +	.verity_required	= ext4_verity_required,
> >  };
> >  #endif /* CONFIG_FS_VERITY */
> >  
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 2f75f06c784a..cd1299e1f92d 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -2257,10 +2257,16 @@ static struct page *f2fs_read_verity_metadata_page(struct inode *inode,
> >  	return read_mapping_page(inode->i_mapping, index, NULL);
> >  }
> >  
> > +static bool f2fs_verity_required(struct inode *inode, pgoff_t index)
> > +{
> > +	return index < (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +}
> > +
> >  static const struct fsverity_operations f2fs_verityops = {
> >  	.set_verity		= f2fs_set_verity,
> >  	.get_metadata_end	= f2fs_get_verity_metadata_end,
> >  	.read_metadata_page	= f2fs_read_verity_metadata_page,
> > +	.verity_required	= f2fs_verity_required,
> >  };
> >  #endif /* CONFIG_FS_VERITY */
> >  
> > diff --git a/fs/read_callbacks.c b/fs/read_callbacks.c
> > index b6d5b95e67d7..6dea54b0baa9 100644
> > --- a/fs/read_callbacks.c
> > +++ b/fs/read_callbacks.c
> > @@ -86,7 +86,9 @@ struct read_callbacks_ctx *get_read_callbacks_ctx(struct inode *inode,
> >  		read_callbacks_steps |= 1 << STEP_DECRYPT;
> >  #ifdef CONFIG_FS_VERITY
> >  	if (inode->i_verity_info != NULL &&
> > -		(index < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT)))
> > +		((inode->i_sb->s_vop->verity_required
> > +			&& inode->i_sb->s_vop->verity_required(inode, index))
> > +			|| (inode->i_sb->s_vop->verity_required == NULL)))
> 
> I think this is a bit easier to follow:
> 
> 		(inode->i_sb->s_vop->verity_required == NULL || 
> 			inode->i_sb->s_vop->verity_required(inode, index)))

Yes, you are right. I will implement the changes suggested by you.

-- 
chandan
