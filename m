From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: improve filename printing
Date: Sun, 28 Apr 2019 14:25:37 +0800
Message-ID: <bc18ee1a-8c31-fe76-fd13-a401ce203095@huawei.com>
References: <20190424175909.71430-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hKdG8-0001PD-2r
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Apr 2019 06:25:56 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hKdG6-00HMjP-MJ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Apr 2019 06:25:56 +0000
In-Reply-To: <20190424175909.71430-1-ebiggers@kernel.org>
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
To: Eric Biggers <ebiggers@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2019/4/25 1:59, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> - Make buffers for pretty-printed filenames 341 bytes long, long enough
>   for 255 (NAME_MAX) base64-encoded bytes.  Then print encrypted
>   filenames in full, base64-encoded.  This will be useful for tests I'm
>   writing which verify the correct ciphertext is stored on-disk.
> 
> - Rename convert_encrypted_name() to pretty_print_filename(), to make it
>   clear that it handles unencrypted names too.  Also make the output
>   'char' rather than 'unsigned char', as it's for printing; and remove
>   the unnecessary return value.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
