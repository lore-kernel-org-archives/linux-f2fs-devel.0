Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22F2C61CE7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Jun 2025 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IXxwv/bAoqZ28p9B22+Tbafjd362x8cJ3T71gKpbqAc=; b=NhWzT5no4X8+CAGJhfigtTjzzl
	0Bmr5j1P3UpvWc/gmBiE0HsJq1CPiDBiQtHLvA028lUZX5GnZmctYdPiaVsaUqxz/wL8WtO0I8i4g
	zSGB6fuBxMqVXrHm555Wof+PBLIV/ZKGsa+Atj6ZXTHtCeU94DhcoLp3vqHLXRMCT20Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uPHsi-0006ey-9N;
	Wed, 11 Jun 2025 09:36:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <shengyong2021@gmail.com>) id 1uPHsh-0006eq-6E
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jun 2025 09:36:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C9arKVQ9vr8ifuJ3fUfdaqenVCfx948RJ/S3pTM4IE0=; b=USmaweePqT7WfKSlOUYtpRxUn6
 sRU/WoswRTkZBmGfuLnRdTr6P8NzY0hCwJH8Oiix/OvackTuhfJ3A/bu2+KO7FEHRpguXSrF628je
 ATKWfpk0DmYdjUjBIcbAlhLhHRgESPGn/+WdYFSLU+hrBs1vwJEKNeCt9a0WSoUzAamY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C9arKVQ9vr8ifuJ3fUfdaqenVCfx948RJ/S3pTM4IE0=; b=jWfDoJHANtd848qqnGZbP5dMmz
 H7kgG5Qm6P1zoRkTGrbDR8CjNG5KFT2GJtRftshu6AZGDlrMRSpfKjUFDa5trZzlWSzUu+sewzKeI
 diNtuvJ/LTo2qSiIb32GGOnP2nFNrA98oJzI1UmMXDo64TsdJOr3qG6/1ZZ2IVLEvY9k=;
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uPHsg-0002Mq-R6 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jun 2025 09:36:27 +0000
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2363e973db1so5834515ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Jun 2025 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749634576; x=1750239376; darn=lists.sourceforge.net;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:cc:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C9arKVQ9vr8ifuJ3fUfdaqenVCfx948RJ/S3pTM4IE0=;
 b=luCfaUDV7w3D6kelFtI+oxyZRirWK44sSORjq4Vw+GcECNJ/AGvvpe7ENeJIU7EKUx
 jTgWnCnvPPKRluuhFvvi0pUozBfEHewM6A/KQXSgyD9Zt6pNbYwxHJk/AYvZMxNgaVU6
 VV3HJFlSP5cYp8TVgToqW6JhF52ySKZ6LfrIymlDC+tW5MO6bw0MALbXFoqexYQaiAfG
 pCGDRSn6PVcM3BgziQZsQlYRnpVn8+09EoDFoNco8zdaA/WjFaR+RzhaR7BTYuTH/iWj
 A6o+It5gmQ5TBi0n7U5HGtUuyVZC1p2egSKOjPDbaVxEAQTI7p2KdwSP4ErgYGgz8pW0
 xMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749634576; x=1750239376;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:cc:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C9arKVQ9vr8ifuJ3fUfdaqenVCfx948RJ/S3pTM4IE0=;
 b=PVbFylJhThD4HzR9FgAXoMCDdQF5y2/t/QtWI+VkHNPN94GqyKUhfjRD2U17iY45c0
 PYW1tTU6RCsmnva7fOTWTzQgLCQJ1ddNHygyzvxSr428vq2iFw+sGZ9wWfCKc/5foEzD
 CN9VJbd+eGE/LTSfVuyBhqjQ9wb9UqhtdOUfNx8bnb5yWPmxDG8ExgtWWz5EqSpiD+E+
 wY3A/pK/6/+a4DkfHvvucu4aE2Ol8gTUM7X+Q1y2jcyy4YSwjO1YkjuSNsnf7A+sVgEU
 fRzkO0+ELZxFvuONJ6R33VUvxTT0JJxu7KZeOyz7Hh0EUrvPujomh3prbqVlYn7ZqsY6
 KzzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6axcgdW2wIE2oPGQfTuP2H7iSuu2Y09Wx/DZMVC6gKhiuFm9exYG4AFhcfxafdkeV51TrmS6XvDg0WA0Vt1iE@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yws9LUV75kXvGmrYTJVB5GH0yjRVAvMLKpwfTdcwLw0EaUAfZWV
 AkgMAd33H9+plCTyRxkgcqT+ZayHUgePd7o5pZge2ZkLHDUY/kUWhqix
X-Gm-Gg: ASbGnctRIfiA3QC1OT5C+Ojnh5Vv1JgwhAtnybBg9H20dK5jrDnecy5NRC5UWmbgxmy
 oeavHE+p+tXwrCIAyoZ4Bt9ru+Oo72hUP450M8MpN3nezkPyKjxCcnLKTWiCYU+X2noe56aTGyj
 1XICYXiu8bJRCHRwLIuu35S+fwNs3It5UmOVNKSQ0nP+w5CNzSm35zCudNgVt5hyp0JmMacMgPf
 xI354xPLcNVwnA2WhfQzrXQT0J+QjMSr6cT+kMDcz+piyWo9AnFEuEUDKkG58gz3UmpL9IqZpZy
 9XhtlR2f/fcpWlmJLdGcMB9Dys1JoWK6PGQ4bghQqbZDqrfrZrqY9vTZs0FH58GqbEa0gV180A=
 =
X-Google-Smtp-Source: AGHT+IHa3XYWEI+4Rk0+l8D3Ved3qQzQVrm62cfeWs+fOvuWX87mAU5MKXpT7GoYRl4BZgGdjIUjCA==
X-Received: by 2002:a17:903:1b44:b0:231:d0da:5e1f with SMTP id
 d9443c01a7336-2364183445fmr34792505ad.21.1749634576050; 
 Wed, 11 Jun 2025 02:36:16 -0700 (PDT)
Received: from [10.189.144.225] ([43.224.245.249])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603507401sm83418915ad.230.2025.06.11.02.36.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 02:36:15 -0700 (PDT)
Message-ID: <7496b4f3-bb8f-40f3-8118-af1aa4ba7062@gmail.com>
Date: Wed, 11 Jun 2025 17:36:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
References: <20250610123743.667183-1-shengyong1@xiaomi.com>
 <20250610123743.667183-3-shengyong1@xiaomi.com>
 <0d34ad8f-7cf7-4a7a-96b6-d7d6d9e5470c@kernel.org>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <0d34ad8f-7cf7-4a7a-96b6-d7d6d9e5470c@kernel.org>
X-Headers-End: 1uPHsg-0002Mq-R6
Subject: Re: [f2fs-dev] [RFC PATCH v2 02/32] f2fs-tools: add option N to
 answer no for all questions
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
Cc: shengyong1@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/11/25 17:22, Chao Yu wrote:
> On 6/10/25 20:37, Sheng Yong wrote:
>> From: Sheng Yong <shengyong1@xiaomi.com>
>>
>> In some scenario, such as autotest, it is not expected to answer
>> question from fsck or dump. To simply answer no to all these questions,
>> this patch adds an option `N' to do that.
>>
>> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
>> ---
[...]
>> diff --git a/fsck/main.c b/fsck/main.c
>> index c5d41597934a..b01a22c8cf53 100644
>> --- a/fsck/main.c
>> +++ b/fsck/main.c
>> @@ -86,6 +86,7 @@ void fsck_usage()
>>   	MSG(0, "  -t show directory tree\n");
>>   	MSG(0, "  -q preserve quota limits\n");
>>   	MSG(0, "  -y fix all the time\n");
>> +	MSG(0, "  -N answer \"No\" for all questions\n");
>>   	MSG(0, "  -V print the version number and exit\n");
>>   	MSG(0, "  --dry-run do not really fix corruptions\n");
>>   	MSG(0, "  --no-kernel-check skips detecting kernel change\n");
>> @@ -114,6 +115,7 @@ void dump_usage()
>>   	MSG(0, "  -f do not prompt before dumping\n");
>>   	MSG(0, "  -H support write hint\n");
>>   	MSG(0, "  -y alias for -f\n");
>> +	MSG(0, "  -N answer \"No\" for all questions\n");
>>   	MSG(0, "  -o dump inodes to the given path\n");
>>   	MSG(0, "  -P preserve mode/owner/group for dumped inode\n");
>>   	MSG(0, "  -L Preserves symlinks. Otherwise symlinks are dumped as regular files.\n");
> 
> It needs to update manual of fsck.f2fs and dump.f2fs as well?

Hi, Chao,

Yes, manual should be updated. I'll add the description in the next version.

Thanks,
shengyong
> 
> Thanks,
> 
[...]
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
