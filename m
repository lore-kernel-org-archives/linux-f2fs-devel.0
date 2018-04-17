From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2/2] f2fs: refactor read path to allow
 multiple postprocessing steps
Date: Tue, 17 Apr 2018 10:42:21 -0700
Message-ID: <20180417174221.GB7428@google.com>
References: <20180416193147.104555-1-ebiggers@google.com>
 <20180416193147.104555-3-ebiggers@google.com>
 <2ccf62e8-070a-7ddc-77a3-cb5ba9347bba@huawei.com>
Reply-To: Eric Biggers <ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@google.com>) id 1f8Ucj-000106-6F
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Apr 2018 17:42:33 +0000
Received: from mail-pl0-f68.google.com ([209.85.160.68])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f8Uch-00Atpe-IY
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Apr 2018 17:42:33 +0000
Received: by mail-pl0-f68.google.com with SMTP id bj1-v6so12375443plb.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 17 Apr 2018 10:42:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2ccf62e8-070a-7ddc-77a3-cb5ba9347bba@huawei.com>
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Michael Halcrow <mhalcrow@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Victor Hsieh <victorhsieh@google.com>

Hi Chao,

On Tue, Apr 17, 2018 at 05:13:12PM +0800, Chao Yu wrote:
> > +
> > +static void bio_post_read_processing(struct bio_post_read_ctx *ctx);
> > +
> > +static void decrypt_work(struct work_struct *work)
> > +{
> > +	struct bio_post_read_ctx *ctx =
> > +		container_of(work, struct bio_post_read_ctx, work);
> > +
> > +	fscrypt_decrypt_bio(ctx->bio);
> > +
> > +	bio_post_read_processing(ctx);
> > +}
> > +
> > +static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
> > +{
> > +	switch (++ctx->cur_step) {
> > +	case STEP_DECRYPT:
> > +		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
> > +			INIT_WORK(&ctx->work, decrypt_work);
> > +			fscrypt_enqueue_decrypt_work(&ctx->work);
> > +			return;
> > +		}
> > +		ctx->cur_step++;
> > +		/* fall-through */
> > +	default:
> > +		__read_end_io(ctx->bio);
> > +	}
> 
> How about introducing __bio_post_read_processing()
> 
> switch (step) {
> case STEP_DECRYPT:
> 	...
> 	break;
> case STEP_COMPRESS:
> 	...
> 	break;
> case STEP_GENERIC:
> 	__read_end_io;
> 	break;
> ...
> }
> 
> Then we can customize flexible read processes like:
> 
> bio_post_read_processing()
> {
> 	if (encrypt_enabled)
> 		__bio_post_read_processing(, STEP_DECRYPT);
> 	if (compress_enabled)
> 		__bio_post_read_processing(, STEP_COMPRESS);
> 	__bio_post_read_processing(, STEP_GENERIC);
> }
> 
> Or other flow.

If I understand correctly, you're suggesting that all the steps be done in a
single workqueue item?  The problem with that is that the verity work will
require I/O to the file to read hashes, which may need STEP_DECRYPT.  Hence,
decryption and verity will need separate workqueues.

> > @@ -481,29 +537,33 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
> >  							 unsigned nr_pages)
> >  {
> >  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > -	struct fscrypt_ctx *ctx = NULL;
> >  	struct bio *bio;
> > -
> > -	if (f2fs_encrypted_file(inode)) {
> > -		ctx = fscrypt_get_ctx(inode, GFP_NOFS);
> > -		if (IS_ERR(ctx))
> > -			return ERR_CAST(ctx);
> > -
> > -		/* wait the page to be moved by cleaning */
> > -		f2fs_wait_on_block_writeback(sbi, blkaddr);
> > -	}
> > +	struct bio_post_read_ctx *ctx;
> > +	unsigned int post_read_steps = 0;
> >  
> >  	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
> > -	if (!bio) {
> > -		if (ctx)
> > -			fscrypt_release_ctx(ctx);
> > +	if (!bio)
> >  		return ERR_PTR(-ENOMEM);
> > -	}
> >  	f2fs_target_device(sbi, blkaddr, bio);
> >  	bio->bi_end_io = f2fs_read_end_io;
> > -	bio->bi_private = ctx;
> 
> bio->bi_private = NULL;
> 

I don't see why.  ->bi_private is NULL by default.

> > +	bio_post_read_ctx_pool =
> > +		mempool_create_slab_pool(128, bio_post_read_ctx_cache);
> 
> #define MAX_POST_READ_CACHE_SIZE	128
> 

Yes, that makes sense.

- Eric

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
