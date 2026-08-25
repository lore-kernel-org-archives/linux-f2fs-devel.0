Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB51EC61CE3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 05:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oycj7uaanoWGUWf0BiOIoChsfZa6dLBGUttXracA4xM=; b=FJxQHQMovK0a2B7+Yg+pRMK6+1
	qA2wCcHZTzEASbRsM8/DClypU4aa0XdUtA01yQZgkwY7xmNGDTvPurq30bvlgl39hlotZinY5lAkj
	/0cI8DE3pM/SlD6QiaOr9en85EWQmYTTG75kxtXTbfokSjplwtKLaUu+lJERE4sf9dbs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyjwm-0001aX-Q8;
	Tue, 25 Aug 2026 05:43:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyjwl-0001aI-BX
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Uyook+4lfMy7Fgwq5BQGk8x+TB/INoTdqDiJrUa1bWU=; b=ctcn0HhJGI1mRLHCPc3wB4md9L
 a6Rn+Emu0TaDHe2UjbrAMyFy93ODQRKTrQp5egqmILn3V4GLcrR9XEeYXv7SafwoTmuX9hTY5A7kE
 5VmLjPhITjVP1lwFPtf/u4r8CNGseyJqsKiliLGHb+idBnWLd6u3bsS75s6wCaN/n5uU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Uyook+4lfMy7Fgwq5BQGk8x+TB/INoTdqDiJrUa1bWU=; b=VUgVKusZTrmbKss2YXrEbjoOxP
 x18kQ6ZgiH54/2CXoey9D4b6xT19epCbwLnwwWY9Z4XEK+brZTlcVipUsVq9sJA86oCwvpkjgjFXv
 veVvTqZSq+wQMekdYN1/YMcZGphsHEaV0+8chOC7gzhE2ibAgrSa5EzqfSlbtqGHrMf8=;
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyjwl-0004n9-M0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:43:43 +0000
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d032846c95so52305225ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 22:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787636618; x=1788241418; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uyook+4lfMy7Fgwq5BQGk8x+TB/INoTdqDiJrUa1bWU=;
 b=s/M6q30ZhsgfjPfnuvzOMDvexS2PDC3c8TcWBl4CpJaQu1v3eOZVLNFum8iIbeYrU4
 0RFuJmOhyr4KJGsTYySCUY1+3k1lfFysvFQRy4WQtfMve/TOGibvhQE/2TJ7SgtaP2tj
 2pVc34jM+pZl8xeDtzoqNYKO9AFiv01dSMknCbGGFue4DVBX3HxzAiZYD99NXx8zVH1h
 Taq9KsMsnNJS7n4Gwpx+2S5sn8ZvZ0GbqZF17ewCFmOkefIkEWP0ShSPP9mJLow/2Mxu
 Z1HPh5gOA5SOqswyOg9mYLmLzCjgWyU6dyGuW9YIsksnXU/tWRpipX/TGGGv9JlRdHcC
 n4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787636618; x=1788241418;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uyook+4lfMy7Fgwq5BQGk8x+TB/INoTdqDiJrUa1bWU=;
 b=AAvFUbo7aTT3U7r20q7gzIRIRV9j6Fge/3EbZseWyNGV2Iij6szkbbNifAXTLD9YNd
 dZBIZOPu6HPAwzgyC7VCrDFDU4ciD/8+1zbwGPJLBTFkZBoLoPXkt+jIPc4QaPr5QSUE
 sD83HzLCOk546p7MNR5rn71xYH2r40aOSGARK90R6dzIR72BgOpovQn62wnHmDrkSs+1
 IPtK1fG3iaIYXA9sVVQUhUDaccnI1cqAN1BeHeTB6RAardbRgcP2A4tydqrr3Hm4zjn+
 L7jmZCBSkMHSaZZuCU+XtV8CEMCMMpQJdhhaCdsTjhh2IRbvxtqyYQDu64A2RNgXTV4+
 L0EA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+80Y4qyoOP8F3G+Oz1zOiBfT+c7LZ76MgRaAMZfpvSkmVeW1J1lV13V1MjQCa3npK6s2dx4YVlCYAVpOsGcns@lists.sourceforge.net
X-Gm-Message-State: AFuF++lNEJTi06J/iC4eIDRuIX6lIp/g3nL8d//cSF3E/2UOqlUB2BRX
 NQbO5H4qASAn4qu/FZsc7yOchGtOrIRs7BaJdHmsabJtXqafPb/ummzw
X-Gm-Gg: AR+sD13jKJgDYVnTjc+8unJBE58x5t0fctmP+P9vCUsaTCIftu20R4SlHfzk9qyj48o
 VWwUE+A9PgLHdk7WzYP3gEejcU0pxlk58jwmJaIcA13lIlV5FPF/CYNyB66+wpybwDtpc5Qd7LV
 dTE+po2MfHD/uQvDNjtINt3Lo82aT62rI6YPhNRlxBPr3EXUWKNhrkUTnXDvcbrqDFNj5hiFJu4
 cJkAfsXHfq20Fuwd77/Y/AzMzqxW488zc1sZfKcZnQsELAsAseaTS/znmrfz2R61pdBbCeAKMBW
 Ugr6WCXvpy8baU4OBNcCbCFptNFCm7EKTrok4n5kwtgWSMWi/4FF25SukeGs22dYqMnC5W1aWcA
 OtjQMS+dVeZm8uyr17XZaRjhTVSjWEUpJjdROFijUQIRVu4P4cwAYKsWGJwhr3B9b6MOPFNZUGd
 hmLTcAlfSnVagv7GlbJXQ5H1aqR7yMGO7GwTkoyamgGaxIk7HaKKv1FQ/PrEzNv+XVkoid2G63i
 peqM7HgyHRPz8zTsfyiZIfL
X-Received: by 2002:a17:902:f68b:b0:2cf:c543:2c7e with SMTP id
 d9443c01a7336-2d64b0ce441mr555240565ad.10.1787636617925; 
 Mon, 24 Aug 2026 22:43:37 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d6768b9c04sm23980225ad.61.2026.08.24.22.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 22:43:37 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Tue, 25 Aug 2026 13:43:31 +0800
Message-ID: <20260825054331.400340-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824134731.3704352-8-chao@kernel.org>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-8-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyjwl-0004n9-M0
Subject: Re: [f2fs-dev] [PATCH v2 07/12] f2fs: cache: use node cache
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
Cc: qwjhust@gmail.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> if (!f2fs_clear_cache_dirty(entry))
> 	goto continue_unlock;
>
> if (!__write_node_cache(entry, ...))
> 	...

and in `__write_node_cache()`:

> if (unlikely(ni.blk_addr == NULL_ADDR)) {
> 	f2fs_cache_clear_uptodate(entry);
> 	dec_page_count(sbi, F2FS_DIRTY_NODES);
> 	...
> 	return true;
> }

`f2fs_clear_cache_dirty()` clears the entry state bit but leaves the DIRTY
radix tag for the writeback transition.  The `NULL_ADDR` return does not reach
that transition, while it clears UPTODATE and decrements the dirty-node count.

What clears the DIRTY radix tag when this already-truncated path returns?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
