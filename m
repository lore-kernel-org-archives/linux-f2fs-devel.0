Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDB3C87FD2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Aug 2025 10:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VbndtuOXBF8fSC1fXGxX/qK8cwX2ayjIJwN9Fd2mjBA=; b=ZxK7PVAiVMRHAncUcmyIbEEk4Y
	8+Hne7ZkIuJsf0rfqWnprT+rf2kLUyrM30mg31Q8OrS0QcBGZF8KkvZPWaUescW1C1D7dR0KAG3N/
	ySb/yomhG9Ns4y2m+WVkYmDd6FZYIXhSGpP5ApiZomcUH0/UcWJyFisL684RI4/axrvA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ulPLK-0003HL-O3;
	Mon, 11 Aug 2025 10:01:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ulPKk-0003FE-35
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Aug 2025 10:00:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5IIlpJGdglAULLyED/0ENT+hkxwpVJ9wMTVp2cfrfz0=; b=T240i1/d5pnpskJWrf5gUaQGJy
 KfD/rDKr47SZbA9ayMg/s4mpcIYxS3UBOS1aEx2Z+StQ3yBIoFNP+SUuEGLTWCbxVMSRPE+L/xb2y
 Y4+bfxjpPznBum1Tuc7b6TBaMCFG+UIyed5EblCENZYaR2t2aDFmtc1EQ3KypjK14bBg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5IIlpJGdglAULLyED/0ENT+hkxwpVJ9wMTVp2cfrfz0=; b=HAYf58j6eHQ99+j6FPsrufmYrl
 b/xosoqxNUy4K2Y819mUXf30t4m64sGnCoFs0qVPouF1c0Pl/qUhGuOyXWHfZlgJ9CAQ7/mGbON0K
 RZyDZwf1ul+RGpVX75eLEkZFUzFmTiDBIl5dW9JGJNyJSc0dRQvxseEd4Lwf3achPzQs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ulPKj-0005Sm-IR for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Aug 2025 10:00:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 374FE5C5756;
 Mon, 11 Aug 2025 10:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4635C4CEED;
 Mon, 11 Aug 2025 10:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754906438;
 bh=e4sQ0Yp8gbBT5jqnkNrkxmwQCURHURp3+kebb7cvCOc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=lCYg24IzOjpcK8b6s5u8Oe/8ovqwYB7xCKfucpVQVhYco/R7M2WCPv5EvSi0Cm2RV
 keAua8TepVU6GDK1SDv0C8OwrFoJSfnUlN1BmsfSBCd43KW+4gLe81gGop7UXUhSUm
 mviZoZTiBPkXJ5hGCbHD355UBbWHeYCVdK32VNdhtLBuXK3K9W/SRE+idtF5OuSAZF
 AXpMuwgrim2CldzCyhgqN/2sn0OezbOgyLi6EBJg+zdfQwQGPBuVVrIczk4/Q7QSNZ
 5nhk6sgpSxZ2TR7QcWe6qj0OuY9hYlSTNQWjziCwMN2mtQo9taI5KYhdEjdV3jweLy
 wN+DrayTKAELg==
Message-ID: <1cb4688b-09a5-4eec-8821-5f740d1537d4@kernel.org>
Date: Mon, 11 Aug 2025 18:00:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>
References: <20250423161527.152834-1-dmantipov@yandex.ru>
 <55c493aa-c015-470f-bdcc-e625ba17a131@kernel.org>
Content-Language: en-US
In-Reply-To: <55c493aa-c015-470f-bdcc-e625ba17a131@kernel.org>
X-Headers-End: 1ulPKj-0005Sm-IR
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: end all corrupted fs writes with
 -EFSCORRUPTED
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Jaegeuk,

I guess we need to drop this patch from dev-test, since xfstests may suffer hang
issue w/ it.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=fb7e51d19b3dc00bb8e3887399eb3e8f8aa1d078

Thanks,

On 4/25/25 10:29, Chao Yu wrote:
> On 4/24/25 00:15, Dmitry Antipov wrote:
>> In 'f2fs_write_end_io()', end all of the in-progress writes with
>> -EFSCORRUPTED if the corresponding error was detected earlier.
>>
>> Reported-by: syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a
>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>> ---
>>  fs/f2fs/data.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 54f89f0ee69b..755806868f0e 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -320,9 +320,11 @@ static void f2fs_write_end_io(struct bio *bio)
>>  {
>>  	struct f2fs_sb_info *sbi;
>>  	struct folio_iter fi;
>> +	bool check;
>>  
>>  	iostat_update_and_unbind_ctx(bio);
>>  	sbi = bio->bi_private;
>> +	check = is_sbi_flag_set(sbi, SBI_NEED_FSCK);
>>  
>>  	if (time_to_inject(sbi, FAULT_WRITE_IO))
>>  		bio->bi_status = BLK_STS_IOERR;
>> @@ -331,6 +333,11 @@ static void f2fs_write_end_io(struct bio *bio)
>>  		struct folio *folio = fi.folio;
>>  		enum count_type type;
>>  
>> +		if (check) {
>> +			mapping_set_error(folio->mapping, -EFSCORRUPTED);
>> +			continue;
> 
> Backing to the implementation, it seems it won't release resources
> below, e.g. missed to call:
> 
> - fscrypt_free_bounce_page()
> - f2fs_compress_write_end_io()
> ...
> - folio_end_writeback()
> 
> I guess it may hang kernel w/ this patch? Or any thing I missed?
> 
> Thanks,
> 
>> +		}
>> +
>>  		if (fscrypt_is_bounce_folio(folio)) {
>>  			struct folio *io_folio = folio;
>>  
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
