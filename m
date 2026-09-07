Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F858C79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 03:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kaArTDyIKOEWElXkCkNCU0APrAP11D4eMTxHTBHk3Rk=; b=mGpA18DUa0/P2EQeETzE5S5edj
	gBHTfys2Gw4tPdu6H3yoffxGXi+KOjAQqi1jgMzIL8QoCHGzV1BJNltKKGYMhf/OE7Y5ygMghRldK
	oMr5eJi54i0jVKvM7uSdJbOHG2HttwD04IeaggFHMsUmT82dpg1RPCklxMMbG7K0kKqk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3QOg-0001Fa-3D;
	Mon, 07 Sep 2026 03:51:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3QOf-0001FT-Dy
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 03:51:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1JnA2gu7/i1xFuuiE6p9ox85cIr8aNojoYOj8kCahsw=; b=lxjO4u0V6C2KGXEjbFW+Dnjlld
 v+4w80bS3QbBp6fQTLQ/xqZeYUIxR7vVu2m2kGX6q8TVs0GyhEFZP2lkccBuimkHjXmDeH/OlCkJi
 zurLWsm686CSfwzEt2zyKu36eiViE3hFRyKIwAmPBJFzY/nmH/hCZTF1D4+FmyHf20T8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1JnA2gu7/i1xFuuiE6p9ox85cIr8aNojoYOj8kCahsw=; b=b2XyvJfsDaOpJt69lHPg09kLxG
 5lO8nunBMMPDx5o9ABUif3iI7TszJdWd/Tot1h2W/IGsweLLVj7iuglHPCnAxTl+uAQb+Ym8ws0Mo
 ZgQur+ugZxHxSvVFicXdvTRMhG+vcbK46wvYVVuKmyX7022Cy4ft+MArHpzfzpB5Nwk0=;
Received: from mail-pj2-f8.google.com ([74.125.227.136])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3QOf-0007Q8-3S for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 03:51:53 +0000
Received: by mail-pj2-f8.google.com with SMTP id
 d9443c01a7336-2db33361b2fso9218575ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 06 Sep 2026 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788753107; x=1789357907; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1JnA2gu7/i1xFuuiE6p9ox85cIr8aNojoYOj8kCahsw=;
 b=GVc7WBXncdhJ2/xj655epqRy+eiOGKHTmheS7bGxWf1YDC5X3TYgG8NKaRUU+IS5AN
 +JLQeOjneseCb9gWo1TdUTniPKWCpWpSMHWyDozgQgbSQ8UHzwxxtPbmvBf1SsoAVpK3
 OBDEDLucE7Oa1T3TYekvSPihGTKnVGEOOWXQ7SP7fTStIQSefG913xvOgNII6xleA0tn
 SsByHxTrl7Gk4lzXI+ZEUF8exGhsKLfTHSex3Et8HU00XSvSnVZcEi08CkjeijTK8RIS
 MvRnvGU4E0ycq4XsAnhMeMK/Oa8tg6qJnx09DYDu55qPjWvtWfhsepCI0vEcyStkm59u
 mTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788753107; x=1789357907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1JnA2gu7/i1xFuuiE6p9ox85cIr8aNojoYOj8kCahsw=;
 b=T8AE77TMjCdLwAlZUuJ+J3kcgr246/v3A9k1tzkRBLF7ljJBJI6UkQk+RNDczniyJO
 Tl018CkiHuAdVy036dTiy7cc10EWynsKPjwxG8jOWgKkvMLifE7rQ++mCRtZ2jetXlqz
 8/G62Pm3/+R+2dYw0fsrhcOZifzNKWKfkfNidayfmQ4dglDmYepENJiXqmGGIYEz4UpM
 s88KlA6ywotCFixVCzZHv1E0p9lYOPfxuwCpycaCVJnUdsLkN5Uh85jtabv3aELeqyjF
 24+TyGhzOgKRvAvpZJ1uLKKb4jN725C9QdKW0V+RQbM+ZzGcrhG3ZZw5QuKgHm+wR7zs
 DGUg==
X-Gm-Message-State: AFuF++klfdL0TdGXH/65JbdKB/j8D8dtdJbSxhwlbI9DCeuLWGprtRQg
 d5TOxQAS/PRAe5cOAKtL4icpRpy3oO9ebSMTIIeOWNdWRq0xMyPYktpd
X-Gm-Gg: AYBFou3oDQIcL5OpPXvh7TL6I/MVDMAr4hOC4sr/Bz9NnPIz7NyJDpUA5OPEzdFObSC
 Dh79wUdSS/suEpjM/6bXEQ6ZKSj4UEbCvDIHP+3T+i+C+teWKKfX7LIHWZ4DTZmM67KLK3iCEjT
 /9Pf0khAGO6estBmvckIy0fbX7HZc5AY/7+WM+IsxmowMzrfkgzqUgBTLsamGf8iERvoApqJkld
 FOZDNcEKvTvOKEL2qkrkUku0MTxCHR7/1jpuHxwEZbhJ8NLHF5Behlhwjexms7ZB6kjVX+InPkK
 PhosjResUweEXg2F0DrGKO9MEetvB4N66MsJt1r8BI9+yK74HipPg29XKEfuTEheLaQclM7sJOM
 A6l+7xOEVuQuN2usMY6VefoeCV2W8ZE+5I2g2dXGGy3zoq0LKgq1K6buJa1OMYhS7XZmH5phyzu
 nMKnD/j8va/sShyDsntoPaSzt6aLGL4oAJ7cGOMOtW64qgTzvrrVr3vu/Flb56lPWoTWPDooBvk
 TeuFC2uDvf9DVXvrY85R709Yw==
X-Received: by 2002:a05:6a21:48a:b0:3d3:b00b:50fc with SMTP id
 adf61e73a8af0-3da3a19faa1mr31235533637.28.1788753107306; 
 Sun, 06 Sep 2026 20:51:47 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc46b4cd51esm2194121a12.2.2026.09.06.20.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 20:51:46 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Mon,  7 Sep 2026 11:51:39 +0800
Message-ID: <20260907035139.2183535-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <83fe187e-e3e8-4328-bbbf-a6751873b9e0@kernel.org>
References: <83fe187e-e3e8-4328-bbbf-a6751873b9e0@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x3QOf-0007Q8-3S
Subject: Re: [f2fs-dev] [PATCH 03/14] f2fs: support regular file buffered
 writes
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 27 Aug 2026 16:56:53 +0800, Chao Yu wrote:
> It detaches from fault injection, why we need to change to use
> __filemap_get_folio()?

Thanks. I missed that.

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
@@ f2fs_write_begin()
 	fgp |= fgf_set_order(len);
-	folio = __filemap_get_folio(mapping, index, fgp,
-				    mapping_gfp_mask(mapping));
+	folio = f2fs_filemap_get_folio(mapping, index, fgp,
+				       mapping_gfp_mask(mapping));

Could you take a look?

-- 
Nanzhe Zhao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
