Return-Path: <SRS0=UMex=V5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08451C433FF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Aug 2019 01:11:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DC320665;
	Thu,  1 Aug 2019 01:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fFYfzy7z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="e/eb3Wis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DC320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hszcw-0003Ou-5E; Thu, 01 Aug 2019 01:11:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hszcu-0003Ol-Fr
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Aug 2019 01:11:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MREHOePjFMfnRBHCI0OzSzUxtSSTXCkFdpCVM8RUFbg=; b=fFYfzy7zgrU1l0Jml/xHOH7skS
 HulvOazePdDHIOjTtxwrLUY49GYN8a43gAttbYU5nJYuMjTjokp8ChWcFiR0FSfY2n260KPnyqT11
 qQ+yZnpB7J8w3Wg1bTyqYkKx6pe+qqi3RKWZz94sGYOSuqoZFK3Pq9uVYhBv6g+XCAeo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MREHOePjFMfnRBHCI0OzSzUxtSSTXCkFdpCVM8RUFbg=; b=e/eb3WisV6VXiZhySBdhcywUSj
 npJD3S3B2ybmLAFNsBMBiAh9SpKdq5zwLrgKB1jHwy2hl7jAxa2uMbnzwjo3dUSUgvlmVHjUxaUtF
 UZdgv6dqiBzJ3GnRCNcChbGnN4Qhrlt1Pcltjan/mYltEerhT1NvSPsI+9ZcibzIUMWs=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hszcs-005vAr-BW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Aug 2019 01:11:28 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6295B2C0F960B1BEB31C;
 Thu,  1 Aug 2019 09:11:19 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 1 Aug 2019
 09:11:14 +0800
To: Nathan Chancellor <natechancellor@gmail.com>, Daniel Rosenberg
 <drosen@google.com>
References: <20190723230529.251659-1-drosen@google.com>
 <20190723230529.251659-4-drosen@google.com>
 <20190731175748.GA48637@archlinux-threadripper>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <5d6c5da8-ad1e-26e2-0a3d-84949cd4e9aa@huawei.com>
Date: Thu, 1 Aug 2019 09:11:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190731175748.GA48637@archlinux-threadripper>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1hszcs-005vAr-BW
Subject: Re: [f2fs-dev] [PATCH v4 3/3] f2fs: Support case-insensitive file
 name lookups
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Nathan,

Thanks for the report! :)

On 2019/8/1 1:57, Nathan Chancellor wrote:
> Hi all,
> 
> <snip>
> 
>> diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
>> index cc82f142f811f..99e79934f5088 100644
>> --- a/fs/f2fs/hash.c
>> +++ b/fs/f2fs/hash.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/f2fs_fs.h>
>>  #include <linux/cryptohash.h>
>>  #include <linux/pagemap.h>
>> +#include <linux/unicode.h>
>>  
>>  #include "f2fs.h"
>>  
>> @@ -67,7 +68,7 @@ static void str2hashbuf(const unsigned char *msg, size_t len,
>>  		*buf++ = pad;
>>  }
>>  
>> -f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
>> +static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
>>  				struct fscrypt_name *fname)
>>  {
>>  	__u32 hash;
>> @@ -103,3 +104,35 @@ f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
>>  	f2fs_hash = cpu_to_le32(hash & ~F2FS_HASH_COL_BIT);
>>  	return f2fs_hash;
>>  }
>> +
>> +f2fs_hash_t f2fs_dentry_hash(const struct inode *dir,
>> +		const struct qstr *name_info, struct fscrypt_name *fname)
>> +{
>> +#ifdef CONFIG_UNICODE
>> +	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
>> +	const struct unicode_map *um = sbi->s_encoding;
>> +	int r, dlen;
>> +	unsigned char *buff;
>> +	struct qstr *folded;
>> +
>> +	if (name_info->len && IS_CASEFOLDED(dir)) {
>> +		buff = f2fs_kzalloc(sbi, sizeof(char) * PATH_MAX, GFP_KERNEL);
>> +		if (!buff)
>> +			return -ENOMEM;
>> +
>> +		dlen = utf8_casefold(um, name_info, buff, PATH_MAX);
>> +		if (dlen < 0) {
>> +			kvfree(buff);
>> +			goto opaque_seq;
>> +		}
>> +		folded->name = buff;
>> +		folded->len = dlen;
>> +		r = __f2fs_dentry_hash(folded, fname);
>> +
>> +		kvfree(buff);
>> +		return r;
>> +	}
>> +opaque_seq:
>> +#endif
>> +	return __f2fs_dentry_hash(name_info, fname);
>> +}
> 
> Clang now warns:
> 
> fs/f2fs/hash.c:128:3: warning: variable 'folded' is uninitialized when used here [-Wuninitialized]
>                 folded->name = buff;
>                 ^~~~~~
> fs/f2fs/hash.c:116:21: note: initialize the variable 'folded' to silence this warning
>         struct qstr *folded;
>                            ^
>                             = NULL
> 1 warning generated.
> 
> I assume that it wants to be initialized with f2fs_kzalloc as well but
> I am not familiar with this code and what it expects to do.
> 
> Please look into this when you get a chance!

That should be a bug, it needs to define a struct qstr type variable rather than
a pointer there.

Jaegeuk, could you fix this in you branch?

Thanks,

> Nathan
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
