Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D0FC79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 03:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sf7KShOoGE21DJxqNe/pi4sL8m4sP9lpMeLPMpsB4Hg=; b=VuAttHFEzJIVNZsR/VtkuYf+Di
	uIMfRB/02D59PsGL7pqr/iK0HaJHBIvrKno8FQwxwl6TwXKzjelA2yMO5y3qdnIFQ20c+FHnDZwTM
	LfsnSG1KiLPF67ExiF9cvHkkdR8dPaADfiZF5Z0G0Ohblp9xehoTvISM9IBRpZ3xAGsI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3QON-0001Y6-T3;
	Mon, 07 Sep 2026 03:51:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3QOM-0001Xr-GA
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 03:51:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SdRZIDgItCQZ5/FdUiskE9UYifheu4uDMl/LTZhZiVM=; b=YxJMP3B5LfHZxT6Ejs1BXw4LwT
 rNMJCdGtcoS1IxhEX6LUeVll5TFLuRx0UnQxNgX/pGwyTyaZK9Fq8nYj/InWi8vgAwO7W+mIdRwwQ
 lrM6i6gU+gNewT7/QDrwXE7XgorXjmi468nlX1xkfR3ofvUzV/TlygwNTCz38MqGGsAo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SdRZIDgItCQZ5/FdUiskE9UYifheu4uDMl/LTZhZiVM=; b=GTYtUmABsfah0fWHB6qteJ/iRn
 KenCxBcG42yNeivfNWVQfF+DfhKAzdHPA3D/butT7qjbbVmOsSl0xO4+NJ3UY4ZFWN4BvR8qgXtTa
 ruldeSp2UU/NYZiRd1xbxCEvQqPeu3L2Rrp+1ZEAs+I7oeGBthfPbvjWjvaaxfeXsFew=;
Received: from mail-pz2-f8.google.com ([74.125.228.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3QOM-0002m1-US for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 03:51:35 +0000
Received: by mail-pz2-f8.google.com with SMTP id
 41be03b00d2f7-cc1d7f6f26aso2020339a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 06 Sep 2026 20:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788753089; x=1789357889; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SdRZIDgItCQZ5/FdUiskE9UYifheu4uDMl/LTZhZiVM=;
 b=alI+Gn5rfXolZ1ghaa9lTF5GGhVZIUEejn7qH7i9F4doN5pIECCHDyUcKgdVDaE/N6
 Wkgy6a2VwUHJ0X6gvljBQ+nJrQTBfYu4Lz+l9IHbjS9bqIxAmpgWpsvsu4YDKHrjO7U6
 wXbm8ielMXJ4Xd49XHsSxAazWIWiy116IcZVII4Jd7mIKoUObo6nJp2lVb57fguiY582
 CmzvxGEPN+LS5nitqZ7UyY8pEGnNk1DZlEBsyjgPHidA+57ZKKLifnqGksVxgjS/Rk4g
 XCMWenjPUGVzqdCqh5lWCp79t8cjgKB4onFrTUAxMaMLpTWSno23w3UI4Z8Q2ze9IwME
 D92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788753089; x=1789357889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SdRZIDgItCQZ5/FdUiskE9UYifheu4uDMl/LTZhZiVM=;
 b=NdbM6S+7z+tynxXEWB9f6NRL29et32hC9lrTbYBwlV6RXPNvdLosyKCTOHN59u+3L3
 m3lqVZKRxewrglCY1RiItIe5nztZaWyiDhE9t3y4DZksFFLSPOhGEJOO8G/hn8TvPy+k
 BExGqDUq1SCzOC0zYGPB3AiyrQiK8SEH5w/E++mCudk8OXsEXekdubEcGdjvz7lLnesO
 H0Qn68H9cBE3OY8/hjZhWBRAwyDIZLN18l+BO+JbroV9BbMYbeWbKgszpoB8KoYGtoEK
 5I4J45yJ1FoK6d46MdreWbI82SRu5j//Ty+z8ZiqL17jtZX+vPicbuJP3OT5UBniPgFc
 vlAA==
X-Gm-Message-State: AFuF++lxy0n+F9CUQx+V75fhOLi9y00pEGu+NDnGjgX92s62y2EhVNy/
 lL3G7qc3z+1zPScp2S/V3W7tGAlxvR9fQn+a+Sxt1BnsRkl4WmR+824q
X-Gm-Gg: AYBFou3MiuqLp5We8VeMNFGOrjEe3vgmsKPo6fgthQqozrwyM3aepenBvWhDVwNuq0g
 4/vcRs5gk/HWfLzTRrKR9in2RO1TizKxid5RTz/CBRjP4AhboBTWz1Wd1JI9cAzv5J5qRHA7OOv
 WwfwHV9Dz54aP5NcK+OA7hR//tC306XjloZmpUX5/V5cyS/cBpXSNx8wYw+EXPxhL0w7E/JE8b4
 fgxwGJt8WrTZdaupbYp66IvQsRcesqolBTJQ8CKY6APUvjvJBqT4LyLpbGOlnksX/8kGNouMRVV
 KE64S7IiBGdrqkmt5g3VaK3i0vpA6qboPBN9TFezgKjcTUHs6xJ2PS+TVdRsFSZF5USQoKZBU1j
 hke6d/8kpybpDTJjIqGMr9N5u7kPl9h54e8QxG/HlQdhHWv9u+awfcNoIIvBkPUsKbt6Qloc4Or
 tHqQCNXCYUY0Aw084aqLwWYPEzhUHV09Kh7Pqoi2armIvJvA2RUYoM+cM0DzAdGat8lkeMK18cG
 Ks52+Iy/e4FVPwKlzFwatGEVQ==
X-Received: by 2002:a05:6a00:981:b0:848:2e7e:353a with SMTP id
 d2e1a72fcca58-861650e9760mr23651640b3a.0.1788753089174; 
 Sun, 06 Sep 2026 20:51:29 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-861527382f0sm3753835b3a.24.2026.09.06.20.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 20:51:28 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Mon,  7 Sep 2026 11:51:20 +0800
Message-ID: <20260907035120.2183257-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <12ab1762-e635-42d6-ab0b-e3358e3b32c2@kernel.org>
References: <12ab1762-e635-42d6-ab0b-e3358e3b32c2@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x3QOM-0002m1-US
Subject: Re: [f2fs-dev] [PATCH 05/14] f2fs: support large folio writeback
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

On Thu, 27 Aug 2026 19:17:33 +0800, Chao Yu wrote:
> We should not relocate dec_page_count() above f2fs_in_warm_node_list() to
> avoid racing bugs.

Thanks for the review, I'll restore the order like this:

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
@@ f2fs_write_end_bio()
-		if (f2fs_folio_has_ffs(folio)) {
-			struct f2fs_folio_state *ffs =
-				(struct f2fs_folio_state *)folio->private;
-
-			finished = atomic_sub_and_test(nr_pages,
-					&ffs->write_pages_pending);
-		}
-
-		while (nr_pages--)
-			dec_page_count(sbi, type);
-
 		if (f2fs_in_warm_node_list(folio))
 			f2fs_del_fsync_node_entry(sbi, folio);

+		if (f2fs_folio_has_ffs(folio)) {
+			struct f2fs_folio_state *ffs =
+				(struct f2fs_folio_state *)folio->private;
+
+			finished = atomic_sub_and_test(nr_pages,
+					&ffs->write_pages_pending);
+		}
+
+		while (nr_pages--)
+			dec_page_count(sbi, type);
+
 		/*
 		 * we should access sbi before folio_end_writeback() to
 		 * avoid racing w/ kill_f2fs_super()
 		 */
 		 ...
 		if (finished) {
 			folio_clear_f2fs_gcing(folio);
 			folio_end_writeback(folio);
 		}

Does this look good to you?

-- 
Nanzhe Zhao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
