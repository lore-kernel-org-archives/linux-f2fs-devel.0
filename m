From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [PATCH V2 10/13] fscrypt_encrypt_page: Loop across
 all blocks mapped by a page range
Date: Wed, 01 May 2019 20:19:35 +0530
Message-ID: <4666731.7CFakFE75r@localhost.localdomain>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
 <20190430171133.GC48973@gmail.com> <20190430230840.GE48973@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.ibm.com>) id 1hLqXZ-0002cQ-4A
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 May 2019 14:48:57 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hLqXU-001jvF-Sw
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 May 2019 14:48:57 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x41EasrT086081
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 1 May 2019 10:48:45 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s7cxy9gnw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 01 May 2019 10:48:45 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.ibm.com>;
 Wed, 1 May 2019 15:48:43 +0100
In-Reply-To: <20190430230840.GE48973@gmail.com>
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

On Wednesday, May 1, 2019 4:38:41 AM IST Eric Biggers wrote:
> On Tue, Apr 30, 2019 at 10:11:35AM -0700, Eric Biggers wrote:
> > On Sun, Apr 28, 2019 at 10:01:18AM +0530, Chandan Rajendra wrote:
> > > For subpage-sized blocks, this commit now encrypts all blocks mapped by
> > > a page range.
> > > 
> > > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > > ---
> > >  fs/crypto/crypto.c | 37 +++++++++++++++++++++++++------------
> > >  1 file changed, 25 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> > > index 4f0d832cae71..2d65b431563f 100644
> > > --- a/fs/crypto/crypto.c
> > > +++ b/fs/crypto/crypto.c
> > > @@ -242,18 +242,26 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
> > 
> > Need to update the function comment to clearly explain what this function
> > actually does now.
> > 
> > >  {
> > >  	struct fscrypt_ctx *ctx;
> > >  	struct page *ciphertext_page = page;
> > > +	int i, page_nr_blks;
> > >  	int err;
> > >  
> > >  	BUG_ON(len % FS_CRYPTO_BLOCK_SIZE != 0);
> > >  
> > 
> > Make a 'blocksize' variable so you don't have to keep calling i_blocksize().
> > 
> > Also, you need to check whether 'len' and 'offs' are filesystem-block-aligned,
> > since the code now assumes it.
> > 
> > 	const unsigned int blocksize = i_blocksize(inode);
> > 
> >         if (!IS_ALIGNED(len | offs, blocksize))
> >                 return -EINVAL;
> > 
> > However, did you check whether that's always true for ubifs?  It looks like it
> > may expect to encrypt a prefix of a block, that is only padded to the next
> > 16-byte boundary.
> > 		
> > > +	page_nr_blks = len >> inode->i_blkbits;
> > > +
> > >  	if (inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES) {
> > >  		/* with inplace-encryption we just encrypt the page */
> > > -		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num, page,
> > > -					     ciphertext_page, len, offs,
> > > -					     gfp_flags);
> > > -		if (err)
> > > -			return ERR_PTR(err);
> > > -
> > > +		for (i = 0; i < page_nr_blks; i++) {
> > > +			err = fscrypt_do_page_crypto(inode, FS_ENCRYPT,
> > > +						lblk_num, page,
> > > +						ciphertext_page,
> > > +						i_blocksize(inode), offs,
> > > +						gfp_flags);
> > > +			if (err)
> > > +				return ERR_PTR(err);
> 
> Apparently ubifs does encrypt data shorter than the filesystem block size, so
> this part is wrong.
> 
> I suggest we split this into two functions, fscrypt_encrypt_block_inplace() and
> fscrypt_encrypt_blocks(), so that it's conceptually simpler what each function
> does.  Currently this works completely differently depending on whether the
> filesystem set FS_CFLG_OWN_PAGES in its fscrypt_operations, which is weird.
> 
> I also noticed that using fscrypt_ctx for writes seems to be unnecessary.
> AFAICS, page_private(bounce_page) could point directly to the pagecache page.
> That would simplify things a lot, especially since then fscrypt_ctx could be
> removed entirely after you convert reads to use read_callbacks_ctx.
> 
> IMO, these would be worthwhile cleanups for fscrypt by themselves, without
> waiting for the read_callbacks stuff to be finalized.  Finalizing the
> read_callbacks stuff will probably require reaching a consensus about how they
> should work with future filesystem features like fsverity and compression.
> 
> So to move things forward, I'm considering sending out a series with the above
> cleanups for fscrypt, plus the equivalent of your patches:
> 
> 	"fscrypt_encrypt_page: Loop across all blocks mapped by a page range"
> 	"fscrypt_zeroout_range: Encrypt all zeroed out blocks of a page"
> 	"Add decryption support for sub-pagesized blocks" (fs/crypto/ part only)
> 
> Then hopefully we can get all that applied for 5.3 so that fs/crypto/ itself is
> ready for blocksize != PAGE_SIZE; and get your changes to ext4_bio_write_page(),
> __ext4_block_zero_page_range(), and ext4_block_write_begin() applied too, so
> that ext4 is partially ready for encryption with blocksize != PAGE_SIZE.
> 
> Then only the read_callbacks stuff will remain, to get encryption support into
> fs/mpage.c and fs/buffer.c.  Do you think that's a good plan?

Hi Eric,

IMHO, I will continue posting the next version of the current patchset and if
there are no serious reservations from FS maintainers the "read callbacks"
patchset can be merged. In such a scenario, the cleanups being
non-complicated, can be merged later.

-- 
chandan
