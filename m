From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: refactor read path to allow
 multiple postprocessing steps
Date: Wed, 18 Apr 2018 10:37:50 -0700
Message-ID: <20180418173750.GA46562@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180416193147.104555-1-ebiggers@google.com>
 <20180416193147.104555-3-ebiggers@google.com>
 <2ccf62e8-070a-7ddc-77a3-cb5ba9347bba@huawei.com>
 <20180417174221.GB7428@google.com>
 <7552c5d3-59fa-69fc-5c76-59d1cff00a1d@huawei.com>
 <20180418171815.GA118681@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f8r1q-0000TQ-ND
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Apr 2018 17:37:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f8r1p-00Bgb6-AO
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Apr 2018 17:37:58 +0000
Content-Disposition: inline
In-Reply-To: <20180418171815.GA118681@google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@google.com>
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Michael Halcrow <mhalcrow@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, Victor Hsieh <victorhsieh@google.com>

On 04/18, Eric Biggers wrote:
> Hi Chao,
> 
> On Wed, Apr 18, 2018 at 02:27:32PM +0800, Chao Yu wrote:
> > Hi Eric,
> > 
> > On 2018/4/18 1:42, Eric Biggers wrote:
> > > Hi Chao,
> > > 
> > > On Tue, Apr 17, 2018 at 05:13:12PM +0800, Chao Yu wrote:
> > >>> +
> > >>> +static void bio_post_read_processing(struct bio_post_read_ctx *ctx);
> > >>> +
> > >>> +static void decrypt_work(struct work_struct *work)
> > >>> +{
> > >>> +	struct bio_post_read_ctx *ctx =
> > >>> +		container_of(work, struct bio_post_read_ctx, work);
> > >>> +
> > >>> +	fscrypt_decrypt_bio(ctx->bio);
> > >>> +
> > >>> +	bio_post_read_processing(ctx);
> > >>> +}
> > >>> +
> > >>> +static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
> > >>> +{
> > >>> +	switch (++ctx->cur_step) {
> > >>> +	case STEP_DECRYPT:
> > >>> +		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
> > >>> +			INIT_WORK(&ctx->work, decrypt_work);
> > >>> +			fscrypt_enqueue_decrypt_work(&ctx->work);
> > >>> +			return;
> > >>> +		}
> > >>> +		ctx->cur_step++;
> > >>> +		/* fall-through */
> > >>> +	default:
> > >>> +		__read_end_io(ctx->bio);
> > >>> +	}
> > >>
> > >> How about introducing __bio_post_read_processing()
> > >>
> > >> switch (step) {
> > >> case STEP_DECRYPT:
> > >> 	...
> > >> 	break;
> > >> case STEP_COMPRESS:
> > >> 	...
> > >> 	break;
> > >> case STEP_GENERIC:
> > >> 	__read_end_io;
> > >> 	break;
> > >> ...
> > >> }
> > >>
> > >> Then we can customize flexible read processes like:
> > >>
> > >> bio_post_read_processing()
> > >> {
> > >> 	if (encrypt_enabled)
> > >> 		__bio_post_read_processing(, STEP_DECRYPT);
> > >> 	if (compress_enabled)
> > >> 		__bio_post_read_processing(, STEP_COMPRESS);
> > >> 	__bio_post_read_processing(, STEP_GENERIC);
> > >> }
> > >>
> > >> Or other flow.
> > > 
> > > If I understand correctly, you're suggesting that all the steps be done in a
> > > single workqueue item?  The problem with that is that the verity work will
> > 
> > Yup,
> > 
> > > require I/O to the file to read hashes, which may need STEP_DECRYPT.  Hence,
> > > decryption and verity will need separate workqueues.
> > 
> > For decryption and verity, the needs separated data, I agree that we can not
> > merge the work into one workqueue.
> > 
> > As you mentioned in commit message, it can be used by compression later, so I
> > just thought that for decryption and decompression, maybe we can do those work
> > sequentially in one workqueue?
> > 
> 
> Sure.  I'm not sure what you're asking me to do, though, since f2fs compression
> doesn't exist yet.  If/when there are multiple steps that can be combined, then
> bio_post_read_processing() can be updated to schedule them together.

Indeed, we may need to consolidate many workqueues into one later, not at this
time, IMO.

> 
> > > 
> > >>> @@ -481,29 +537,33 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
> > >>>  							 unsigned nr_pages)
> > >>>  {
> > >>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > >>> -	struct fscrypt_ctx *ctx = NULL;
> > >>>  	struct bio *bio;
> > >>> -
> > >>> -	if (f2fs_encrypted_file(inode)) {
> > >>> -		ctx = fscrypt_get_ctx(inode, GFP_NOFS);
> > >>> -		if (IS_ERR(ctx))
> > >>> -			return ERR_CAST(ctx);
> > >>> -
> > >>> -		/* wait the page to be moved by cleaning */
> > >>> -		f2fs_wait_on_block_writeback(sbi, blkaddr);
> > >>> -	}
> > >>> +	struct bio_post_read_ctx *ctx;
> > >>> +	unsigned int post_read_steps = 0;
> > >>>  
> > >>>  	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
> > >>> -	if (!bio) {
> > >>> -		if (ctx)
> > >>> -			fscrypt_release_ctx(ctx);
> > >>> +	if (!bio)
> > >>>  		return ERR_PTR(-ENOMEM);
> > >>> -	}
> > >>>  	f2fs_target_device(sbi, blkaddr, bio);
> > >>>  	bio->bi_end_io = f2fs_read_end_io;
> > >>> -	bio->bi_private = ctx;
> > >>
> > >> bio->bi_private = NULL;
> > >>
> > > 
> > > I don't see why.  ->bi_private is NULL by default.
> > 
> > As we will check bi_private in read_end_io anyway, if it is not NULL, we will
> > parse it as an ctx, am I missing something?
> > 
> 
> We're allocating a new bio.  New bios have NULL ->bi_private.

+1.

bio_init() does memset();

> 
> > Thanks,
> > 
> > > 
> > >>> +	bio_post_read_ctx_pool =
> > >>> +		mempool_create_slab_pool(128, bio_post_read_ctx_cache);
> > >>
> > >> #define MAX_POST_READ_CACHE_SIZE	128
> > >>
> > > 
> > > Yes, that makes sense.
> > > 
> 
> Actually it's the number of contexts preallocated in the mempool, so I'm going
> to call it NUM_PREALLOC_POST_READ_CTXS.  It's similar to
> 'num_prealloc_crypto_ctxs' in fs/crypto/crypto.c.

Could you please post v2?

Chao,

Let me know, if you have other concern on this. Otherwise, let me queue v2
firmly.

Thanks,

> 
> Eric

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
