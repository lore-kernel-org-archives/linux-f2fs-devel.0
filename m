Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7CFC3DA61
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 21 Jul 2024 13:17:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sVWRn-0007x5-5D;
	Sun, 21 Jul 2024 13:17:55 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sunjunchao2870@gmail.com>) id 1sVWRm-0007wz-6V
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 21 Jul 2024 13:17:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GzEpCjsjIp6sYSRacrUzJwQO3F6b2sWIew49EATOwp8=; b=O/VeTwCHTRaOlKLjCXyURS36AH
 mVfimO2LkO1KxjuTG7X0cjDYtKlcsbNlpBfB3LNchVetTAXZgtfcJfPYQ1s1/2rr1Uacnl0lIBuxD
 U2+z2LMsb5wsEzrOAs69grQAs/kQo5foAjgKCvgrvNKoYGD91L8nrw7wmd81JckDrraw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GzEpCjsjIp6sYSRacrUzJwQO3F6b2sWIew49EATOwp8=; b=S
 ZRXtcv8y7Vu8vGrbDFf0NUDFgNqDIMg7xW+hf5ztA86qAQzWgek48/KTe4wa9tqZ5EADWNS5EOoQh
 jQwb4yLITczn7UGva+O5zWKDT/UiNXbTt1GgWcTQ3cnC43R+7Br82Xj/1WldIPglcsI2GslzUHwT/
 lUGl7zYA6X3jeVtg=;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sVWRl-0001dQ-J5 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 21 Jul 2024 13:17:54 +0000
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1fd66cddd07so12257515ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 21 Jul 2024 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721567862; x=1722172662; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GzEpCjsjIp6sYSRacrUzJwQO3F6b2sWIew49EATOwp8=;
 b=aS8yMdztipxeKjmMySnQN57Fjdf/POTJS94d2+p6TJik5ZxPCf+slZz8YDsLlwTbrX
 EVsNI/4oI9Iyj5gCtpdsKqOw982/Sjjc7nnE/Xvw5cCcQc2uTFGqPDdx/j1AMO1MgQ/L
 jE19CFuhOCALW+CL6iakbtCNHZNmWoH2Hl8QZadspDxEKWCYGp0exx6LyWuvJ3LIIJ6s
 nrtE/D98xAdvogw8rP+PLnx7ZhfyTN0pTAhXv7jZuWruPDFSzLIW196IoclapMTwtuIw
 ZfaRLJKEAt+wjN7hmjUrxZYurymBQ6NrU7wBME529/+4GCw43mztbgP3J5OjY4TRsUrP
 VwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721567862; x=1722172662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GzEpCjsjIp6sYSRacrUzJwQO3F6b2sWIew49EATOwp8=;
 b=HKnmgS39UXLuDyKqzd1gODj6iL0plhiPp9enGz27tp1uR3DSSfX1CCe2082ABulkxx
 zxoUXMIV2jOWMjfu8xiQB8W+E27CQouc+t/rGRi85zTLLr4UZEOFQYr2tp7BzjpQJgdD
 ZCbPd9wSVboPhJQjdisRykIop/b6eMrd0VbbRHDRyRlfr/V87Lbv7TOaHz92tRWPtWiz
 7mdz87yMe7c4Te4p+zge3gwW6Ts//pMHJTfO71CPSLV57XT8Wevv6IOL3NAeYd/btU75
 oniiajrHYcjQmUZtzafNjZC+Smht7tFzMNiE78NApREXmXJoZoVvnJjJVpmYn9dXO+8z
 U0Bg==
X-Gm-Message-State: AOJu0Yz7x3QR4YMw/Fxji//Qlz6aI0cKw8KM+A0SmGBsqFNi/kuxQq5U
 jFjvckA93taYDFv/h8eQB0qW3BE9Y/VGZvJi7LSkHRKYz9qsCU3CY32s4umx0kg=
X-Google-Smtp-Source: AGHT+IH6R9ynfwE+0eurshHVOLF91ave0yo4EXhomkxky+OGsAGKKl+QkiJ4vRxMLdduLWidgO4QMw==
X-Received: by 2002:a17:902:d4d0:b0:1fd:5eab:8c73 with SMTP id
 d9443c01a7336-1fd745e0028mr29657735ad.35.1721567862415; 
 Sun, 21 Jul 2024 06:17:42 -0700 (PDT)
Received: from localhost ([60.206.64.40]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f436d26sm36171475ad.201.2024.07.21.06.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 06:17:42 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 21 Jul 2024 09:17:38 -0400
Message-Id: <20240721131739.260027-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Headers-End: 1sVWRl-0001dQ-J5
Subject: [f2fs-dev] [PATCH 1/2] f2fs: fix macro definition
 on_f2fs_build_free_nids
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
Cc: Julian Sun <sunjunchao2870@gmail.com>, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The macro on_f2fs_build_free_nids accepts a parameter nmi,
but it was not used, rather the variable nm_i was directly used,
which may be a local variable inside a function that calls the macros.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b72ef96f7e33..34eeb2a8598c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -20,7 +20,7 @@
 #include "iostat.h"
 #include <trace/events/f2fs.h>
 
-#define on_f2fs_build_free_nids(nmi) mutex_is_locked(&(nm_i)->build_lock)
+#define on_f2fs_build_free_nids(nmi) mutex_is_locked(&(nmi)->build_lock)
 
 static struct kmem_cache *nat_entry_slab;
 static struct kmem_cache *free_nid_slab;
-- 
2.39.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
