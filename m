Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5F9C6FA8E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Sep 2022 18:25:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oXo7V-0002kZ-Ck;
	Mon, 12 Sep 2022 18:25:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oXo7U-0002kT-OC
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+d28bepiquHWlxilFueNkEADr0o+je+NLAZFPUKTbIY=; b=hF9ur3uhcZMjZItvRz9tcMVj7Z
 uZk8CjPJe74AUPZLU7saTBTQ5Mrin9QLgB8xE+FDk0PKHGziio3D+dGcMKYVCsGkuoNcrPWCVlmww
 Rgl1HzediE+Q+is2ZUOfhDUvQPl7O4VUgg4VuZerTeY/w2nVoKEn5H1oAp1Rj7o9+4Mw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+d28bepiquHWlxilFueNkEADr0o+je+NLAZFPUKTbIY=; b=fUY0oGUoquaqsvUwOBy8I9/y7O
 GgSH32H+4XxUargH2s3A1BE2JMhSREM0ZHpydQ5MjDzaao/yhhtVnbs0CBMGr/XeatJ2dARUA3lON
 WiSqtlTrtFUwMBTMNecMv+ChWikfnyv0GZLHKDLHprlkUyyVQdV64vxlnGl1aMLGaR/8=;
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oXo7c-0003la-Is for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Sep 2022 18:25:32 +0000
Received: by mail-pf1-f172.google.com with SMTP id b75so4190597pfb.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Sep 2022 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=+d28bepiquHWlxilFueNkEADr0o+je+NLAZFPUKTbIY=;
 b=UAvqeyyLl/jMM4GcLetiAfdFe+mfb9lKdBJfnSYldnUlLqvzEBn5ucL+x7WyU328TX
 0/H9S52HSNuIFSWZ4YunFZhb9lMParyxzhpSfOriqzuEWl4nNQDfXBSCfd6PHcpEoArW
 hhkS/p47e7LTcdSDzPM5i4xcpSpua30NKF59fo2sfAm71y1h24VA6yU9gVJkZlr/HpKr
 kqbY0nqvYn5G/9BlH7ySmMvtkJ2+1WrYDojpVBZMQYHQaBxAnxx6msfYZA0Ac2gMEKOu
 fegLeVBCk9YxpsZnm6jcCKHOUZl7iJDeg1NFYcwjZsYJ40Ns924KMhs4Yi3zIL0Ak4bb
 eQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=+d28bepiquHWlxilFueNkEADr0o+je+NLAZFPUKTbIY=;
 b=yHdV8uS8gamK150OApwkCHKmhTAxXBGQgggrDexdlbrq+5dSWzcbqglLS8jIsS0kSi
 DkAuD9EeJLk0DZ8HTTC9tF+7WeSJwk01F/lyNBZSRbFjELvwlvpzPEydAsUJ/BJnvggc
 hoXaVDiyhzdDwOe9gOru0ySLjcYxst/adhH8STTU5WzZRwZepkLMj1ToxYr9EbOP5rT2
 KJ7ktEhLQCatu29a+LNPpE1VqLVR/C4wGA+S98hS+OD6IazoaSkBpraXRhHy8HKWT/5f
 H74Tn0sR+LQrhQiWblH/78qD0fV/sMWFTZ7siq4ac3dpuOZxvYZxydItAWdmMqHIcL9Z
 G/kQ==
X-Gm-Message-State: ACgBeo3zMl0fYgZXgYuhgNnrzXG3jJ4qaDZPXFDwzQRFGQTIgrbBQKnw
 YWzh98/oiyXcf5hnjy4OK97iL4Nc7+KGig==
X-Google-Smtp-Source: AA6agR4Zy8VhOF+ibmC8k8zrBCfvKjb+HhgReHqq+fiRHDk/WfuNUZ7mRsbRn+TR1ll+VP/jfqTVhg==
X-Received: by 2002:a05:6a00:1691:b0:53b:3f2c:3257 with SMTP id
 k17-20020a056a00169100b0053b3f2c3257mr28670886pfc.21.1663007122141; 
 Mon, 12 Sep 2022 11:25:22 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
 by smtp.googlemail.com with ESMTPSA id
 x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 11:25:21 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 12 Sep 2022 11:22:02 -0700
Message-Id: <20220912182224.514561-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oXo7c-0003la-Is
Subject: [f2fs-dev] [PATCH v2 01/23] pagemap: Add filemap_grab_folio()
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
Cc: linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 "Vishal Moola \(Oracle\)" <vishal.moola@gmail.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ceph-devel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add function filemap_grab_folio() to grab a folio from the page cache.
This function is meant to serve as a folio replacement for
grab_cache_page, and is used to facilitate the removal of
find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0178b2040ea3..4d3092d6b2c0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -547,6 +547,26 @@ static inline struct folio *filemap_lock_folio(struct address_space *mapping,
 	return __filemap_get_folio(mapping, index, FGP_LOCK, 0);
 }
 
+/**
+ * filemap_grab_folio - grab a folio from the page cache
+ * @mapping: The address space to search
+ * @index: The page index
+ *
+ * Looks up the page cache entry at @mapping & @index. If no folio is found,
+ * a new folio is created. The folio is locked, marked as accessed, and
+ * returned.
+ *
+ * Return: A found or created folio. NULL if no folio is found and failed to
+ * create a folio.
+ */
+static inline struct folio *filemap_grab_folio(struct address_space *mapping,
+					pgoff_t index)
+{
+	return __filemap_get_folio(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+			mapping_gfp_mask(mapping));
+}
+
 /**
  * find_get_page - find and get a page reference
  * @mapping: the address_space to search
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
