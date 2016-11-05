From: Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 1/2] fscrypto: don't use on-stack buffer for
 filename encryption
Date: Sat, 5 Nov 2016 07:13:49 -0800
Message-ID: <20161105151349.e5ap547uno3hfit7@kmo-pixel>
References: <1478210582-86338-1-git-send-email-ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kent.overstreet@gmail.com>) id 1c32fP-0006BA-Kk
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 05 Nov 2016 15:13:59 +0000
Received: from mail-pf0-f193.google.com ([209.85.192.193])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1c32fO-0005HF-S8
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 05 Nov 2016 15:13:59 +0000
Received: by mail-pf0-f193.google.com with SMTP id y68so11070213pfb.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 05 Nov 2016 08:13:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1478210582-86338-1-git-send-email-ebiggers@google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@google.com>
Cc: tytso@mit.edu, richard@nod.at, linux-f2fs-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org, luto@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org

On Thu, Nov 03, 2016 at 03:03:01PM -0700, Eric Biggers wrote:
> With the new (in 4.9) option to use a virtually-mapped stack
> (CONFIG_VMAP_STACK), stack buffers cannot be used as input/output for
> the scatterlist crypto API because they may not be directly mappable to
> struct page.  For short filenames, fname_encrypt() was encrypting a
> stack buffer holding the padded filename.  Fix it by encrypting the
> filename in-place in the output buffer, thereby making the temporary
> buffer unnecessary.
> 
> This bug could most easily be observed in a CONFIG_DEBUG_SG kernel
> because this allowed the BUG in sg_set_buf() to be triggered.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

> -		alloc_buf = kmalloc(ciphertext_len, GFP_NOFS);
> -		if (!alloc_buf)
> -			return -ENOMEM;
> -		workbuf = alloc_buf;

Vmalloc memory does have struct pages - you just need to use vmalloc_to_page()
instead of virt_to_page. Look at drivers/md/bcache/util.c bch_bio_map() if you
want an example.

It would be better to just fix the sg code to handle vmalloc memory, instead of
adding a kmalloc() that can fail (and an error path that inevitably won't be
tested).

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
