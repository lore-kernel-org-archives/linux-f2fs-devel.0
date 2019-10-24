Return-Path: <SRS0=euTy=YR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB499CA9EAF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:11:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37FF20856;
	Thu, 24 Oct 2019 09:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dWO36FNT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Tmkpbt6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37FF20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iNZ92-0006g4-DA; Thu, 24 Oct 2019 09:11:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1iNZ91-0006fx-9G
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Oct 2019 09:10:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vLx7B15Fhx7WnCFp7VwEYv/oEVLnA92RZBoBhPgKCZU=; b=dWO36FNTcTrk4h2kh0OBeDelmS
 oQpx+3yDdjqIQY/TchjANvRSGOpopcl0UkIcJUuojtWUtv1VZCnFS6DPXuzSWhb5erm83cZpROOIB
 wSS7MRlYVPOQdDTlZC3deHJmSFjXD91yWjUoYZqQ/41LoVtdJqT1JuU1CR82mmk8sMSI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vLx7B15Fhx7WnCFp7VwEYv/oEVLnA92RZBoBhPgKCZU=; b=Tmkpbt6fVG8tOTc94NkOGbwDw9
 nh1AVdSMa3zkTd7p7nvcMuMGaS8xlrGjC9c1KuB0ShoNZjlC+NCxJRrRz6k6xMPfmmzKOODcIp5wA
 3bmKFZ+fd820nE+EbEUYlQfW79WkneIyBZIRcrrf/lYbuR4KSmZR/rZYXNVbEKw9+Od4=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iNZ8y-001K05-Rt
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Oct 2019 09:10:59 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DE483A4BAB710FA894A6;
 Thu, 24 Oct 2019 17:10:48 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 24 Oct
 2019 17:10:45 +0800
To: Ju Hyung Park <qkrwngud825@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20191022171602.93637-1-jaegeuk@kernel.org>
 <20191022171602.93637-2-jaegeuk@kernel.org>
 <CAD14+f3CH7=JTvsvFKzoZCX=GL5W9qs0LD0i-o+gHO39aW7-kw@mail.gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <4f16a3f6-edf8-7a35-68cd-0d45d8f596ba@huawei.com>
Date: Thu, 24 Oct 2019 17:10:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD14+f3CH7=JTvsvFKzoZCX=GL5W9qs0LD0i-o+gHO39aW7-kw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1iNZ8y-001K05-Rt
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: support data compression
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Ju Hyung,

On 2019/10/23 1:53, Ju Hyung Park wrote:
> Hi Jaegeuk and Chao,
> 
> Nice to see this finally getting into shape :) Great work
> I'm excited to see possible use-cases for this in the future.
> 
> Would f2fs compress files automatically like how btrfs' "compress" option works?
> Or is it per-extension basis for now?

We support three ways to active file compression:

Quoted:

- To enable compression on regular inode, there are three ways:
* chattr +c file
* chattr +c dir; touch dir/file
* mount w/ -o compress_extension=ext; touch file.ext

> 
> On Wed, Oct 23, 2019 at 2:16 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>> +compress_algorithm=%s  Control compress algorithm, currently f2fs supports "lzo"
>> +                       and "lz4" algorithm.
> 
> I see absolutely no reason to support regular lzo variant at this time.
> Everyone should use lz4 instead of lzo. If one wants zlib-level
> compression, they should use zstd.
> 
> However, there's recent conversation on new lzo-rle and how it could
> be a better candidate than lz4.
> 
> Since the mainline now have lz4, zstd and lzo-rle, I don't think
> supporting lzo is a good idea.

This is just RFC version, we can change it anytime, let's decide whether
deleting it before final version.

> 
>> diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
>> index 652fd2e2b23d..c12854c3b1a1 100644
>> --- a/fs/f2fs/Kconfig
>> +++ b/fs/f2fs/Kconfig
>> @@ -6,6 +6,10 @@ config F2FS_FS
>>         select CRYPTO
>>         select CRYPTO_CRC32
>>         select F2FS_FS_XATTR if FS_ENCRYPTION
>> +       select LZO_COMPRESS
>> +       select LZO_DECOMPRESS
>> +       select LZ4_COMPRESS
>> +       select LZ4_DECOMPRESS
> 
> This is a bad idea.
> This unnecessarily increases kernel binary image when no the user
> intends to change the defaults.
> 
> For example, my Android kernel doesn't use lzo anywhere and this
> wouldn't be welcome.

Agreed, maybe we need a kconfig entry for compress.c as well.

> 
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> new file mode 100644
>> index 000000000000..f276d82a67aa
>> --- /dev/null
>> +++ b/fs/f2fs/compress.c
>> @@ -0,0 +1,1066 @@
>> +static unsigned int offset_in_cluster(struct compress_ctx *cc, pgoff_t index)
>> +static unsigned int cluster_idx(struct compress_ctx *cc, pgoff_t index)
>> +static unsigned int start_idx_of_cluster(struct compress_ctx *cc)
> 
> Looks like these would be better if they were explicitly marked as inline.
> 
>> +static void f2fs_init_compress_ops(struct f2fs_sb_info *sbi)
>> +{
>> +       sbi->cops[COMPRESS_LZO] = &f2fs_lzo_ops;
>> +       sbi->cops[COMPRESS_LZ4] = &f2fs_lz4_ops;
>> +}
> 
> Would it be possible for f2fs to use generic crypto compression APIs?
> Hardcoding for lzo/lz4 would make it harder to venture future different options.
> 
> Have a look at mm/zswap.c:__zswap_pool_create_fallback().

Not sure, I think I could look into it later, now Jaegeuk and I have to
stabilize codes first.

Thanks for your advice anyway.

> 
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index c681f51e351b..775c96291490 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -155,6 +163,7 @@ struct f2fs_mount_info {
>>  #define F2FS_FEATURE_VERITY            0x0400
>>  #define F2FS_FEATURE_SB_CHKSUM         0x0800
>>  #define F2FS_FEATURE_CASEFOLD          0x1000
>> +#define F2FS_FEATURE_COMPRESSION       0x2000
> 
> How would older versions of f2fs behave if an image was used by the
> latest f2fs and have compressed pages?
> I hope fail-safes are in place.

That patch haven't merged yet, since there is detailed implementation which is
under discussion.

Thanks,

> 
> Thanks.
> 
>> --
>> 2.19.0.605.g01d371f741-goog
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
