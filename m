From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [PATCH V2 11/13] ext4: Compute logical block and the
 page range to be encrypted
Date: Wed, 01 May 2019 19:41:49 +0530
Message-ID: <12288535.bgPuNnGEdQ@localhost.localdomain>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
 <20190428043121.30925-12-chandan@linux.ibm.com>
 <20190430170151.GB48973@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hLqAq-0004wf-M2
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 May 2019 14:25:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hLqAp-001ijP-F0
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 May 2019 14:25:28 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x41EMQu8143917
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 1 May 2019 10:25:21 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s7a176v0n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 01 May 2019 10:25:21 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Wed, 1 May 2019 15:25:19 +0100
In-Reply-To: <20190430170151.GB48973@gmail.com>
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
Cc: tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, hch@infradead.org, linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org

On Tuesday, April 30, 2019 10:31:51 PM IST Eric Biggers wrote:
> On Sun, Apr 28, 2019 at 10:01:19AM +0530, Chandan Rajendra wrote:
> > For subpage-sized blocks, the initial logical block number mapped by a
> > page can be different from page->index. Hence this commit adds code to
> > compute the first logical block mapped by the page and also the page
> > range to be encrypted.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > ---
> >  fs/ext4/page-io.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> > index 3e9298e6a705..75485ee9e800 100644
> > --- a/fs/ext4/page-io.c
> > +++ b/fs/ext4/page-io.c
> > @@ -418,6 +418,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
> >  {
> >  	struct page *data_page = NULL;
> >  	struct inode *inode = page->mapping->host;
> > +	u64 page_blk;
> >  	unsigned block_start;
> >  	struct buffer_head *bh, *head;
> >  	int ret = 0;
> > @@ -478,10 +479,14 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
> >  
> >  	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) && nr_to_submit) {
> >  		gfp_t gfp_flags = GFP_NOFS;
> > +		unsigned int page_bytes;
> > +
> 
> page_blk should be declared here, just after page_bytes.
> 
> > +		page_bytes = round_up(len, i_blocksize(inode));
> > +		page_blk = page->index << (PAGE_SHIFT - inode->i_blkbits);
> 
> Although block numbers are 32-bit in ext4, if you're going to make 'page_blk' a
> u64 anyway, then for consistency page->index should be cast to u64 here.
> 
> >  
> >  	retry_encrypt:
> > -		data_page = fscrypt_encrypt_page(inode, page, PAGE_SIZE, 0,
> > -						page->index, gfp_flags);
> > +		data_page = fscrypt_encrypt_page(inode, page, page_bytes, 0,
> > +						page_blk, gfp_flags);
> >  		if (IS_ERR(data_page)) {
> >  			ret = PTR_ERR(data_page);
> >  			if (ret == -ENOMEM && wbc->sync_mode == WB_SYNC_ALL) {
> 
> 

I will implement the changes that have been suggested here.

-- 
chandan
