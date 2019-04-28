From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: improve xattr value printing
Date: Sun, 28 Apr 2019 14:25:10 +0800
Message-ID: <242d8b26-592b-57da-bd1f-3466bf714803@huawei.com>
References: <20190424175730.70979-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hKdFh-0004m3-RE
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Apr 2019 06:25:29 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hKdFf-00GF2m-Hn
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Apr 2019 06:25:29 +0000
In-Reply-To: <20190424175730.70979-1-ebiggers@kernel.org>
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

On 2019/4/25 1:57, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> - Print the values of xattrs that have an unknown ->e_name_index, rather
>   than ignoring them.
> 
> - Replace char with u8.  Otherwise xattr values containing bytes >= 0x80
>   are printed incorrectly on platforms where char is signed.
> 
> - Only parse the encryption xattr if it has a known format number and
>   size.  Otherwise print it as hex.
> 
> - Remove incorrect le16_to_cpu() on ->e_name_len which has type u8.
> 
> - Consolidate the code that prints the xattr value as hex.
> 
> - Constify pointers to the xattr entry.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
