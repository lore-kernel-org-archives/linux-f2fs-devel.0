Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15FCC982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9oeRXtNEw5e8FYMctnDzqNWiQh1OA3kBnAS/3AgKRyA=; b=IWR577KtJAa6lPRqSs2a4nlaev
	e2Bvt6frma9KFfHGyPKrNzkEOyeTPAlnvuppSmFNTVN0PdeMFnNqnBX6HSegWoA+KHXBgU0Q1F7xc
	z1OUSFla2//QmE/KoLK9aOHGl9mm5SIa0UkAEks+sA4/zTzS19162yEGYLjROoHMeZz4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9156-0005cD-6X;
	Tue, 22 Sep 2026 14:02:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhanxusheng1024@gmail.com>) id 1x9154-0005c6-Az
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:02:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hMdmUhrxd/BwBfU0bmZvimeKVs/NpBNIsOEZ52l12Hw=; b=X4YweUgjq2EzXWIm4AP1eAPnPK
 LEE6km0cdeAjHiE2WphsIBzbnXBXB/sxbn8IzcmxLeDM36croSWmmddclNc1bkw8iTaRH35P5jyvF
 W4BkC/Pyx0MBfC+d3Jq64lTeJwqeW75xbj9HfbGh5jEHtjOU69PIvNGRYURY7f002eno=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hMdmUhrxd/BwBfU0bmZvimeKVs/NpBNIsOEZ52l12Hw=; b=kPhdmgROXCwWVe+o5ousY+Az5E
 1Ri3CDvoid0dhaNDLUwnfnAgzn4QkGJHheq6arAClQ8nOf+IJEuaUwrCooVVNNpAwa2aAhukDUev0
 9oa+HpcNJ7AyVnOvUBN6fxz4eY01pEX7RqyZSfTRQJIqac2tDzON0Dqqa+stB386AA5c=;
Received: from mail-pj2-f12.google.com ([74.125.227.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9150-0005B3-Hl for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:02:43 +0000
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2dd58e1e2c7so38203555ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 07:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790085757; x=1790690557; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hMdmUhrxd/BwBfU0bmZvimeKVs/NpBNIsOEZ52l12Hw=;
 b=ChCoFXWo7UM4G9L5T+w+8ttbc4k6XDC/rbz/M062638uaN/npcIbRTQvlLecS4Py0V
 1ISbQB+jncFxhzmKj7Lw0kWHY70TOEkTQwT1M/MbGtZkflGZmTUHWll87Sc8Tvpe3wZU
 7RZ999LW2Z+Vdd+dVKg7fSPzs7F9edrVBtvrcWEd5nPjHzNFRexnddZiTcUTaTsKU0kv
 8jVsw6g0cYbEoeazTJCidHwQl7Bh/FQt5ycoPGi/vGdw4JLfqmq6wgj4RX4wJUUbbrZT
 VZRrZrSzYuClaoXb3JYyk8RClp3emMu/wpp88CZj+grDQtLZEu0p0WN+fxW8jK16tyWU
 Yybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790085757; x=1790690557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hMdmUhrxd/BwBfU0bmZvimeKVs/NpBNIsOEZ52l12Hw=;
 b=UwKznIpRkolzHbgC3KNkKwVAtEemgsYNkdbYDTh3Q4/18JLHsQrXm8Udu7fIN55Hwl
 hb2xGKsLRwDaf4TSUHQITPjsSml4PQOtHFVyF9S46q8vSCZSJ32xLzEuRd2riYjOpbfw
 QPV8PBYoI9/v90EInTQzsrzQsN5zzyKBTYwukYCfVvOYCsfsBDA7GkiQsxFodudB9uR2
 ksCKQFoBHywbkLZsICnVwcPSPH7HHb7nXtciv03ouWjHmYdNnvDO1mZwoH0/s862gBn3
 kYBJ7Ng43fhVZOxJYEenXMGx3qV2yOH3PuOg7uFEXMMIIGdH6VQMMbIhMN0qfhbaOl1d
 LlGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8/J2bKTDQW/sE9HM5dMSOCSrOsIYIio47rvgKhUuuWwv2hoYLkxC0CMmayd01e1fnxuLB9XQsvPyMKLPFyrqy@lists.sourceforge.net
X-Gm-Message-State: AFuF++kgusT0fJ7CjkXBhQkVZBelM3ec35igaa0wBdJdxfblXAEr6ePZ
 4GGg5uZoWkOT1lIZdItxv51QFC8xE+Ed3TW98Mygc48yuLp/SsBlknnG
X-Gm-Gg: AYBFou0p31lJeceIDtUrSutL2Tbr/S67eTCY4hVfjQ3a3SJ5cAgfxX6rjRLIUOvB/AM
 5BH5HoEdfEVOOtLctYIYMq76I6X75PsWmt9gomLaLq/Qyk+UsFFxy76Cq+dXU+wkACUQbiWNxE+
 B0bvrtYRxYS5bc49Dmccq0Wsd+yFgWTusMGHwkTHHZZDNFWJFv7LFKgaZYAirt2/whyUtkE7WRd
 4Ng7Oaw5Tx2CfcUoO+2zzcphHBySZZHcRjYHieF4X0HqzNGnRU+B7XZHdSOTJmXTf1s2KbVzrjd
 +vCYTXs/JDd+idVZvneCMQkRFHf3Ya8AA9m5WYj4e6Pkafu/qSnO1TBdBanSyXAn1rjIS1JR47n
 r7oGDb0O3i1eRoXtvx76UAPyZkqIDWvhkXDEzPXycL4LdR+JqsfB0ArAMri5KLjEcAN50PUY79u
 R7BOAoxsOU2VXgbp/z+5781o3gScc244ygGO3jUSLO2edI+39CjkkoBaFMlMsDp2K7j/XOnuhcJ
 zT3oMD0Kd4=
X-Received: by 2002:a17:902:e551:b0:2c8:248a:5dbb with SMTP id
 d9443c01a7336-2df609b47b9mr15715095ad.7.1790085756497; 
 Tue, 22 Sep 2026 07:02:36 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d0588e9sm11123465ad.76.2026.09.22.07.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 07:02:36 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Daeho Jeong <daehojeong@google.com>, Sunmin Jeong <s_min.jeong@samsung.com>
Date: Tue, 22 Sep 2026 22:02:29 +0800
Message-ID: <20260922140230.2931816-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922123443.2908902-1-zhanxusheng@xiaomi.com>
References: <20260922123443.2908902-1-zhanxusheng@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1x9150-0005B3-Hl
Subject: Re: [f2fs-dev] [PATCH] f2fs: recompute the pinned area boundary
 after resizing
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
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Please hold this one.

resizable_tail_secno is only checked against the section count at mount and
remount, so after a shrink it can exceed MAIN_SECS(), and the subtraction in
f2fs_adjust_pinned_area_boundary() is unsigned:

	sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
		MAIN_SECS(sbi) - F2FS_OPTION(sbi).resizable_tail_secno);

resizable_tail_secno=200 on a 248 section image, shrunk to 192 sections:

	without the patch   MAIN_SECS 192, boundary 48
	with the patch      MAIN_SECS 192, boundary 192

min() picks MAIN_SECS(), has_unpinned_area() turns false and the reservation
is gone.  The stale 48 kept more of the tail clear, so here the patch makes
things worse.

On an exact match the boundary becomes 0 and

	f2fs_gc_range(sbi, 0,
		sbi->pinned_area_max_secno * SEGS_PER_SEC(sbi) - 1, ...)

passes UINT_MAX as end_seg.  f2fs_gc_range() does not bound end_seg and
get_valid_blocks() indexes sit_i->sentries[] with no check.  I did not hit
the exact match; that part is from reading the code.

What should happen when the reservation no longer fits: refuse the resize,
drop it, or clamp resizable_tail_secno?  I will respin once that is settled.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
