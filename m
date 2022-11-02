Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAA4C3A5A3
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Nov 2022 16:11:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oqGKz-0007bq-Ca;
	Wed, 02 Nov 2022 16:11:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1oqGKk-0007aH-Bt
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Nov 2022 16:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lbrAaY6idpkhBtxaaJGwUptujZ0EZql70PDCszR9xSI=; b=gtJ6gH5tyRxO90F/snaIIDUUDY
 YYg+HPZ0EofXmF3lyaoDh+Z5WY6fyRtdpR5C3LO9nKiiPRkmyFf4UJBC98qTh4j9gQ+Y16DuQzMZI
 pK8975mlQK1L08GAkJuQoNDVK0ghxpuDGswdYGAuiFr7ixTsoodLJ+TzLGZDtvqHQekI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lbrAaY6idpkhBtxaaJGwUptujZ0EZql70PDCszR9xSI=; b=jmmEMayaYMOB2GXKi3oRZte9hd
 WeocCNNMvfgMxxEdpeqWlOsufuBi+FDib1O1PHXr4XanIRLCjm3aVgt1E1asCL1q6ja+fAvb+xB7a
 Vfws9Rc4CUHjBD93fGqRqM1xoc0KI5jnNHIuzWFytQQwiFCbnUvOpcwvUQ5yBj/bEuyk=;
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oqGKg-009a9C-5s for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Nov 2022 16:11:18 +0000
Received: by mail-pg1-f172.google.com with SMTP id b62so6261691pgc.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Nov 2022 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbrAaY6idpkhBtxaaJGwUptujZ0EZql70PDCszR9xSI=;
 b=b22oyujJhcmEnIoOWyXlmdwFsWtvDDEbrYWi+tTl/IKQZadCXIum/ufaWsfiuhgQWs
 P0ejMWAXsFFxmUJWgjcqRWL6iDvmTJOBHMdvrWNuXSDSGhujg7k49tnS+xBECZ0DDC1D
 QEeKOjhkuj2U1fYHa3KM1TSvYvE4FrIPOrf/CN/DjK2k7Ii76jHakZpfzft8GgAI2TOi
 3dtL4HfeEfRRNgP7Mp0GAgu1ZDeKvnGqK9CY4nsrmEB3lEEy5PFMtwvBwHVV7JaSQ4Oc
 JqTTGwFIB+4o1Aa2ylRSznqsjRcz5BF5gANEbFRauGWLvr7/47QbInfDSn9b5QQsOYI/
 8XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbrAaY6idpkhBtxaaJGwUptujZ0EZql70PDCszR9xSI=;
 b=cQP6bc1kMq4R35mBODRL1+SFuSAi7jUpDeJLqQrQkUTvMNU+FSGOTPLjTzpdIfeuzx
 oZhdCqduCGp6BtBNlQxuvzhvMf/DDW1iLuSefKXnHG45HGVX/zelvNY8ndKHwAstJdt0
 GEv6kgvfNyMd5WKtUc2nbmYlz5Nb2xe/V4UZFPhYO2/ruDM+4r+Y1oEQDlWpV/KyHyF/
 BrZdLwfl5+mgONuhtTuEaG4rFbr4DvvH1mJryZlTsodVtTUWGWogWT8sWP18iet4adzj
 +x9VuwX7HPOxohwl93pCXaQdpjhDHeycMbebA85GmMXSIPZS+hmAe5GgW2pdE5XbNHBa
 azLw==
X-Gm-Message-State: ACrzQf1whVdnSADM5f5lreel+4VrrajORZB/3FCBiWM15sHxMsYVqpbx
 RdRGMSA+uR5kg0VBQnNQQHs=
X-Google-Smtp-Source: AMsMyM4joqcseRqaAlvGrQuZzcj3D8bSzB3ystEOG//zbMspTew1XCkFbHiKN+JLHdCdJZX/wxsOQg==
X-Received: by 2002:a05:6a00:1253:b0:56d:8742:a9ff with SMTP id
 u19-20020a056a00125300b0056d8742a9ffmr15514058pfi.5.1667405468483; 
 Wed, 02 Nov 2022 09:11:08 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
 by smtp.googlemail.com with ESMTPSA id
 ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 09:11:08 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Wed,  2 Nov 2022 09:10:09 -0700
Message-Id: <20221102161031.5820-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102161031.5820-1-vishal.moola@gmail.com>
References: <20221102161031.5820-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1oqGKg-009a9C-5s
Subject: [f2fs-dev] [PATCH v4 01/23] pagemap: Add filemap_grab_folio()
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
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add function filemap_grab_folio() to grab a folio from the page cache.
This function is meant to serve as a folio replacement for
grab_cache_page, and is used to facilitate the removal of
find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bbccb4044222..74d87e37a142 100644
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
2.38.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
