Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EE9C53219
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Jul 2026 04:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IxzAdf8Et5ntcxynhAtBN51f2ySH1g5MGZoRl4owKYk=; b=I0KQxxfnTEEuzM8pQEHCScT+HK
	jL06PlebvVcWzBMSA2ShUtXeqZIrE3/Dlz5W2VQq2Kvg6MQ7a7Dp36DROU/jWGdcg2GUQx0zylYU6
	4nEIR9jj9w8MrwW/jcpCqJh8KBuK8lcx47CCcTdoKaxbMI8+iNJ+u0PVjFoUKu6PeV5k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wovjK-00057R-BZ;
	Wed, 29 Jul 2026 04:17:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <rochan.avlur@gmail.com>) id 1wovjJ-00057K-UM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 04:17:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cfXUKL6KEgJ9xC0lbVLlHmoRQoa/+Lwi/4872gF1r5g=; b=FvATYAe7Ny70oAye9AFq93Rcjg
 0X0fBFwyfokaI2c8mTEw2wkYZdntaG2tcJ8iv9PnasbsF3qSSFDiWCleRy6IGWIKfvSqa5C4FTWlb
 YIUdBELXKXH9CPycvOZvC4TPENi65jETEZ9HWxhumHBp7NdRcawn8pDpil5o2Rd8VN9Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cfXUKL6KEgJ9xC0lbVLlHmoRQoa/+Lwi/4872gF1r5g=; b=f
 9QrjBIE3O3GPD8U8a/32at735HBc06f1kxbDfObt/Yx5bjylZsZYFODbJFuKa36vRyLRHE/XoV3+X
 MZQx1pXMl96nYPs5Dgt9scZGOXpcHZ3oKQJ20DT5tNOB20YLOxPrRvTeITWPvR2oHFYRM2er1CafG
 v6Jcv1Wo5dAPFE4Y=;
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wovjF-0000QE-Om for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 04:17:17 +0000
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cb5a6aa8760so255637a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 21:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785298628; x=1785903428; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cfXUKL6KEgJ9xC0lbVLlHmoRQoa/+Lwi/4872gF1r5g=;
 b=KqiySvp0is15EOhcP3zBTvTCNOwOt1sxlErm8KxJ8MfKsR2FF8PmnkpMvcgEJYOo/X
 O8DLPuZ3zKL6xdiVU9jF9ojfUL1irfI9u0Mf1sCaWBlu0M8RbXrYdojapHBBHlv5aHSd
 lG2Oz+xyLekpJYp16yZ/kVvXyYOBAEUNhdQbYi4Q2wPYTnW0m01r0ePZBlgG5nHfNHAa
 903l46EGcN6LZexQ05L6PLs8jy9dVYOf3zlk7FLcAMt2y9o/oCOtiGAXAP4DYSebin8v
 9hb/CASVIB9AdvW9IIaJaUrfkKQZYr/CHJJga/xUptCctMPt85lLdPKHBPbH30VoOfhJ
 fn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785298628; x=1785903428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cfXUKL6KEgJ9xC0lbVLlHmoRQoa/+Lwi/4872gF1r5g=;
 b=LJFWxmqDl9Rx7nFaJ2e309bFOcV+KdBeN/KHcKmMBfEIYw6EUmv6UxdMNscc4wSShw
 OucORMarNYt91U+9GYZymJY2+3GJb28C4th2JRu9bvYy4eUAWopa1aVOxFvdb/wd2y1T
 XCKIgSmW7RxI6UNlSDSa6lvt8DbyAJr1h83yl88628H7ZuGHLEdLQ3/k1ZskByl1etZa
 PLZDs74c0hYF3boZfmOeZaObgSajoUpTCImefsHxc3T/+AKrDg7IVupHV3Ss9Y++3oqL
 6VNP4W2mTGuTKkamZXYO7ZaRjVKKx+LjX3QBAY735tgCye6w1NetGSe4dU8NPlfoed3E
 zhTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqBlf2vp7qn/sBKOKPOjhQVw32JDd30U0r379EGVcfiMPv+ZNgTq7AQtiJXWn9ue8ga2ymtM3OG0OD0MzjSmX4@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz0w2fsSOGp3CE73Us1WgbRQ4gFNptuF0QPjtN8mSpeZXeK/1Fn
 0o2SaTWgfD4mD03V249xUpJvhV3lT0Fr5jDf6eYVYOIe0UHPfwFH7Vo=
X-Gm-Gg: AR+sD11fDFOGvqjxIm/uaL1DrZBviLkCQMtBo5mIyG4tD1ks1BZdz271z2gckK5KCI4
 LJdAWCmmnQolfETXJqlhWRbpyP+zFA+J0UqOcAxA1vzJTSxrI/l2zW5yrTd9hL4kyimzwiur7Dg
 /5lbRkrqC4XQkZ4yM3Ar4YAQq2quV4VzYomH3EQX5GznMkt5+2yLmmMZ/o5Wm+gq9pGtu77j0dJ
 agfatJORVLV6ztXi59tWF+GGDDEZn8c3+TR8I+eR1AzG5Nrz4Pgh7Fgj7TCP8OyAyeXh0bVb6Mp
 qaCJngG92d3SxhEVYwohgx4WvumcILDDmMreiOtkeV9pHunz9IW94zwVzddqR6vZIuBfumW2kCu
 6cKi5T1c/wjE9WssKfz6HEzmJa3hr2usfX49r1KqqvvBG8A0k1g9lgvUQ02SgJCq8mU+1O/7cHR
 VIrUBZKBCxbZ4TzPeUPqEhPDjNIL6Nxw0ZqmV+fCDs3q4UuhyuUiGZDvTiiw7iQn9l7/PxsXOI3
 vy52yMGEhnzdTjA49mF3oAyw5ZOVCOWdXs72hBn
X-Received: by 2002:a05:6a21:2d43:b0:39f:59c8:f302 with SMTP id
 adf61e73a8af0-3c8ba5d0a12mr6192619637.37.1785298627978; 
 Tue, 28 Jul 2026 21:17:07 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:88b0:bed0:1488:2a4e:85f:d739])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b6d14bsm4507589eec.10.2026.07.28.21.17.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jul 2026 21:17:07 -0700 (PDT)
From: Rochan Avlur <rochan.avlur@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 28 Jul 2026 21:16:56 -0700
Message-ID: <20260729041656.51967-1-rochan.avlur@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Headers-End: 1wovjF-0000QE-Om
Subject: [f2fs-dev] [PATCH] f2fs: use the mount idmap for the owner check in
 f2fs_xattr_advise_set()
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
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Rochan Avlur <rochan.avlur@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_xattr_advise_set() calls inode_owner_or_capable() with
&nop_mnt_idmap before allowing the advise xattr to be set, instead of
the idmap that was passed into the handler.

Since f2fs supports idmapped mounts, this compares the caller's fsuid
against the unmapped on-disk owner rather than the mapped owner; resulting
in the actual owner to be wrongly denied with -EPERM. Use the idmap
argument that was already passed to the xattr handler instead.

Fixes: 984fc4e76d63 ("f2fs: support idmapped mounts")
Cc: stable@vger.kernel.org
Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
---
 fs/f2fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 610d5810074d..281e2fd6c778 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -118,7 +118,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 	unsigned char old_advise = F2FS_I(inode)->i_advise;
 	unsigned char new_advise;
 
-	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+	if (!inode_owner_or_capable(idmap, inode))
 		return -EPERM;
 	if (value == NULL)
 		return -EINVAL;
-- 
2.45.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
