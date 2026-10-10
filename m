Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA10CA9EBE
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Oct 2026 10:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cxTV7II7NIFeK37tTMFu37m3o30y/8tHgomZoFQEDeY=; b=WIIrdzSb8ThjMjWiOnweb9O5AZ
	mOqH1IKlomF0Op45EZZMRZgxcIG4WtRTAw68xmMuMFe1YVlSnqRmHiKPe360aDSm60mJtIRFSDZpb
	sQGocgbnXRI+OLaX1O3Ho/xWG75zOhG5vN1CeSkaXr9gTumA+jEYRT1prehw5oaQOX/U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFTuo-0006TF-P4;
	Sat, 10 Oct 2026 10:02:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xFTua-0006T0-36
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 10:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=youus/0MWr200AhumZ5bukgeONt49YRtQSAKCUYXfRQ=; b=YNqfxBo9qZZLRqK8X2w4fZXStk
 IIuLbd5isXtr6CYcxv0lp+EUJq/uCncU5sk8PE+wDhuAMSB8GwvEcenPxTks0pMADyOdxVQaN1mvP
 Hf+7fxMb+KHfpTBUkQ8c/8HIqyKPLGMdFrqDtktQxQJ0MLiQWyYaiBRM5Rec9goRBzxE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=youus/0MWr200AhumZ5bukgeONt49YRtQSAKCUYXfRQ=; b=AS+o4FzAkdaA5P4s8ooN8Ut74Y
 YM4O0oXUO6AHrl77qHdyRKJDffGY+LqaqtV/2ocP+1tzYLTvsZlpGG8MUzl9PH4jjOX0FxVF2TNmE
 78KEMFR9SZMlCDZKW/4cI9tJxzhZ78Ws7D5Q4BAo/U2XutRdutyo9v8gkOzmgtK4HGeI=;
Received: from m16.mail.126.com ([117.135.210.6])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFTuY-0007UW-0k for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 10:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yo
 uus/0MWr200AhumZ5bukgeONt49YRtQSAKCUYXfRQ=; b=bQEg4Mzv79VLKtzjbO
 4T6S/I+eT5XLJ/IN1xcnvVwG3H9jCDTJ7t5Y1Vc/kMmi6lHk8LYtdDBkBNlEPNiV
 7mO6mC8qHmf+85dsk4SQzDzjDOFI8RpFHn+4p6fp7KwfUCRGODiv9Ymx3ne78nIt
 eZNQd4OUIRGBrY+LSn8GFdosA=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3914aDcpqFxmnAw--.19359S2; 
 Sat, 10 Oct 2026 18:02:04 +0800 (CST)
To: daeho43@gmail.com
Date: Sat, 10 Oct 2026 18:02:02 +0800
Message-ID: <20261010100202.1431895-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_wmA_=kVvyu1m7XbVUpUt6J9BZeW=zqHFkD-+Lt3Gtz3g@mail.gmail.com>
References: <CACOAw_wmA_=kVvyu1m7XbVUpUt6J9BZeW=zqHFkD-+Lt3Gtz3g@mail.gmail.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3914aDcpqFxmnAw--.19359S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUnLvKUUUUU
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBohyXZ2rKDRz+mgAA3b
X-Headers-End: 1xFTuY-0007UW-0k
Subject: Re: [f2fs-dev] [PATCH v3 03/17] f2fs: support regular file buffered
 writes on large folios
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: baohua@kernel.org, nzzhao@126.com, Ryan.Roberts@arm.com,
 daehojeong@google.com, zhaonanzhe@xiaomi.com, jyescas@google.com,
 Dev.Jain@arm.com, David.Hildenbrand@arm.com,
 linux-f2fs-devel@lists.sourceforge.net, zhangbo56@xiaomi.com,
 kaleshsingh@google.com, jaegeuk@kernel.org, lipengfei28@xiaomi.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks for pointing out!

I choosed the design to let prepare_large_folio_write_begin() and
prepare_large_folio_atomic_write_begin() complete the read IO internally
to keep the code easy to implement, so I have to call them after the
f2fs_folio_wait_writeback() in f2fs_write_begin().

I'm going to add the writeback wait after re-locking the folio in
f2fs_folio_may_unlock_balance_fs().  For order-0, one more f2fs_folio_wait_writeback
probably doesn't matter much, right?

Thanks,
Nanzhe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
