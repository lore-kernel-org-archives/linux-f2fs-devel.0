From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 2/2] f2fs: refactor read path to allow
 multiple postprocessing steps
Date: Mon, 23 Apr 2018 11:25:33 +0800
Message-ID: <e317d735-22f7-60ec-ed5a-f78364705e2a@huawei.com>
References: <20180418180948.152031-1-ebiggers@google.com>
 <20180418180948.152031-3-ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fAS6r-0006fR-TZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 03:25:45 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fAS6p-0088Za-Hl
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 03:25:45 +0000
In-Reply-To: <20180418180948.152031-3-ebiggers@google.com>
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
To: Eric Biggers <ebiggers@google.com>, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org, Michael Halcrow <mhalcrow@google.com>, Victor Hsieh <victorhsieh@google.com>

On 2018/4/19 2:09, Eric Biggers via Linux-f2fs-devel wrote:
> Currently f2fs's ->readpage() and ->readpages() assume that either the
> data undergoes no postprocessing, or decryption only.  But with
> fs-verity, there will be an additional authenticity verification step,
> and it may be needed either by itself, or combined with decryption.
> 
> To support this, store a 'struct bio_post_read_ctx' in ->bi_private
> which contains a work struct, a bitmask of postprocessing steps that are
> enabled, and an indicator of the current step.  The bio completion
> routine, if there was no I/O error, enqueues the first postprocessing
> step.  When that completes, it continues to the next step.  Pages that
> fail any postprocessing step have PageError set.  Once all steps have
> completed, pages without PageError set are set Uptodate, and all pages
> are unlocked.
> 
> Also replace f2fs_encrypted_file() with a new function
> f2fs_post_read_required() in places like direct I/O and garbage
> collection that really should be testing whether the file needs special
> I/O processing, not whether it is encrypted specifically.
> 
> This may also be useful for other future f2fs features such as
> compression.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
