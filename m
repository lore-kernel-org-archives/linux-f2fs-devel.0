Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12571C61DBE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 03:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m1TdOKUdZLl1NavEH0sjpDCPAys1MWx2zPA3pbbkNuQ=; b=R8YSROlYG3snV6eJmNpS3smImJ
	OeQ5FH3AUiX6b1nWEhQeFlN37cYoGFpEUqbmic4HnEylRv+So7XQqstW2zr3w/KmPAqtPqwx4f3au
	c80tt0NfS3mms+u4xpViAJtSOs/00M7hZlIspYny+GNwUa0i0gQM8Ye+hMToHqcpc0Tw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzQjX-0005PM-TK;
	Thu, 27 Aug 2026 03:24:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzQjW-0005P5-Ld
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 03:24:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B4G2OfJCXFLvW2ZfNSEkZA/MTBfDinhkmQW7E0EEGmg=; b=e+ZdXrgTCkw+jRPNiEI/j1h4D3
 NsFQK6oT5V/iCLupWooMV7m3HWB8BTzbDqj14navyLj5sGIKII9tHPB7upzWOBIER9vJbent7P21K
 fZtB+JmRyNuKUOwaXuevIoMZ5eNttIxypBai2aw37FAIlg2sa0jZFeqF4ZVSZhTuHdJk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B4G2OfJCXFLvW2ZfNSEkZA/MTBfDinhkmQW7E0EEGmg=; b=GOiHvUL+mokkCcEREe2oae3Xim
 JJW9uIWfmDl8jHBuKLBhW8qNi5hH+oRDF7t5uCFwEmwgsCAA/JVf/5CMyLFCDyxj52uzhFqkY/diD
 lo3YVEbp7frVuHcypMz5T/Kma08QSN4adPsKmLgukn+r3WtonDk3q4chSCwQ7O+TkMt4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzQjX-0004sN-1P for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 03:24:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7AAD343639;
 Thu, 27 Aug 2026 03:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970AB1F000E9;
 Thu, 27 Aug 2026 03:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787801089;
 bh=B4G2OfJCXFLvW2ZfNSEkZA/MTBfDinhkmQW7E0EEGmg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=RPL7oQ0up+oc0cCToP8b5TKS8AxovnR1IzMRqix6Vmwkmje6chMoco4ODwl1t6Jav
 Ri2nMvlI/OOo3KxhDkPKaXdAwap4hvtj3Qw/PchHYWydhkB+wuvNURyXHUM2pynmj0
 YNwa0IQnNH8PoNOlWaF+HbWzMcykJMDEw4h7yapyUTj3+wVTj5y3mNYuHLfZ9hfv0m
 ZwIBe2S7qLvCh+y7KrS9TdaBKzBUjWt8oITv4oLnqu0QJSX4ndwzgy3B7b5byOMCUJ
 22AZx4apCjKcCCcOWJKanhthVHRTAPyVcSaGNKiWOwr47S35UtH3s90uTSacuE/QWW
 736g+CLF6/TMA==
Message-ID: <8e02060f-6921-4d3c-abb2-cc36fe1e9594@kernel.org>
Date: Thu, 27 Aug 2026 11:24:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20260825130126.2078627-1-chao@kernel.org>
 <20260825130126.2078627-10-chao@kernel.org>
 <CACOAw_w+QMkTNK=McScLHh1gpm6UFjxLSnVxhFMsgsuArLA=qQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACOAw_w+QMkTNK=McScLHh1gpm6UFjxLSnVxhFMsgsuArLA=qQ@mail.gmail.com>
X-Headers-End: 1wzQjX-0004sN-1P
Subject: Re: [f2fs-dev] [PATCH v3 09/12] f2fs: cache: use compress cache
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/27/26 04:04, Daeho Jeong wrote:
>> -static void f2fs_truncate_cache(struct f2fs_cached_block *entry,
>> +void f2fs_truncate_cache(struct f2fs_cached_block *entry,
>>                                         bool drop_dirty)
> 
> -> __f2fs_truncate_cache() without locking?
Or, I guess you mean we need a cleanup here?

What about:

void f2fs_truncate_cache(struct f2fs_cached_block *entry, bool drop_dirty)
{
	if (!entry->cache)
		return;
	f2fs_do_truncate_cache(entry, drop_dirty);
}

static void f2fs_truncate_cache_locked(struct f2fs_cached_block *entry, bool drop_dirty)
{
	f2fs_lock_cache(entry);
	f2fs_truncate_cache(entry, drop_dirty);
	f2fs_unlock_cache(entry);
}

f2fs_truncate_cache() was exported for using in other .c file, in the meantime,
static f2fs_truncate_cache_locked() can be used inside cache.c.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
