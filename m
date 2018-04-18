From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: refactor read path to allow
 multiple postprocessing steps
Date: Wed, 18 Apr 2018 14:27:32 +0800
Message-ID: <7552c5d3-59fa-69fc-5c76-59d1cff00a1d@huawei.com>
References: <20180416193147.104555-1-ebiggers@google.com>
 <20180416193147.104555-3-ebiggers@google.com>
 <2ccf62e8-070a-7ddc-77a3-cb5ba9347bba@huawei.com>
 <20180417174221.GB7428@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f8gZF-0002Pg-0c
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Apr 2018 06:27:45 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f8gZC-009Rpz-QY
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Apr 2018 06:27:44 +0000
In-Reply-To: <20180417174221.GB7428@google.com>
Content-Language: en-US
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Michael Halcrow <mhalcrow@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Victor Hsieh <victorhsieh@google.com>

Hi Eric,

On 2018/4/18 1:42, Eric Biggers wrote:
> Hi Chao,
> 
> On Tue, Apr 17, 2018 at 05:13:12PM +0800, Chao Yu wrote:
>>> +
>>> +static void bio_post_read_processing(struct bio_post_read_ctx *ctx);
>>> +
>>> +static void decrypt_work(struct work_struct *work)
>>> +{
>>> +	struct bio_post_read_ctx *ctx =
>>> +		container_of(work, struct bio_post_read_ctx, work);
>>> +
>>> +	fscrypt_decrypt_bio(ctx->bio);
>>> +
>>> +	bio_post_read_processing(ctx);
>>> +}
>>> +
>>> +static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
>>> +{
>>> +	switch (++ctx->cur_step) {
>>> +	case STEP_DECRYPT:
>>> +		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
>>> +			INIT_WORK(&ctx->work, decrypt_work);
>>> +			fscrypt_enqueue_decrypt_work(&ctx->work);
>>> +			return;
>>> +		}
>>> +		ctx->cur_step++;
>>> +		/* fall-through */
>>> +	default:
>>> +		__read_end_io(ctx->bio);
>>> +	}
>>
>> How about introducing __bio_post_read_processing()
>>
>> switch (step) {
>> case STEP_DECRYPT:
>> 	...
>> 	break;
>> case STEP_COMPRESS:
>> 	...
>> 	break;
>> case STEP_GENERIC:
>> 	__read_end_io;
>> 	break;
>> ...
>> }
>>
>> Then we can customize flexible read processes like:
>>
>> bio_post_read_processing()
>> {
>> 	if (encrypt_enabled)
>> 		__bio_post_read_processing(, STEP_DECRYPT);
>> 	if (compress_enabled)
>> 		__bio_post_read_processing(, STEP_COMPRESS);
>> 	__bio_post_read_processing(, STEP_GENERIC);
>> }
>>
>> Or other flow.
> 
> If I understand correctly, you're suggesting that all the steps be done in a
> single workqueue item?  The problem with that is that the verity work will

Yup,

> require I/O to the file to read hashes, which may need STEP_DECRYPT.  Hence,
> decryption and verity will need separate workqueues.

For decryption and verity, the needs separated data, I agree that we can not
merge the work into one workqueue.

As you mentioned in commit message, it can be used by compression later, so I
just thought that for decryption and decompression, maybe we can do those work
sequentially in one workqueue?

> 
>>> @@ -481,29 +537,33 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
>>>  							 unsigned nr_pages)
>>>  {
>>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>> -	struct fscrypt_ctx *ctx = NULL;
>>>  	struct bio *bio;
>>> -
>>> -	if (f2fs_encrypted_file(inode)) {
>>> -		ctx = fscrypt_get_ctx(inode, GFP_NOFS);
>>> -		if (IS_ERR(ctx))
>>> -			return ERR_CAST(ctx);
>>> -
>>> -		/* wait the page to be moved by cleaning */
>>> -		f2fs_wait_on_block_writeback(sbi, blkaddr);
>>> -	}
>>> +	struct bio_post_read_ctx *ctx;
>>> +	unsigned int post_read_steps = 0;
>>>  
>>>  	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
>>> -	if (!bio) {
>>> -		if (ctx)
>>> -			fscrypt_release_ctx(ctx);
>>> +	if (!bio)
>>>  		return ERR_PTR(-ENOMEM);
>>> -	}
>>>  	f2fs_target_device(sbi, blkaddr, bio);
>>>  	bio->bi_end_io = f2fs_read_end_io;
>>> -	bio->bi_private = ctx;
>>
>> bio->bi_private = NULL;
>>
> 
> I don't see why.  ->bi_private is NULL by default.

As we will check bi_private in read_end_io anyway, if it is not NULL, we will
parse it as an ctx, am I missing something?

Thanks,

> 
>>> +	bio_post_read_ctx_pool =
>>> +		mempool_create_slab_pool(128, bio_post_read_ctx_cache);
>>
>> #define MAX_POST_READ_CACHE_SIZE	128
>>
> 
> Yes, that makes sense.
> 
> - Eric
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
