Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA163CC6B2F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LB3PJn9xS2iX/UH9qvVQdZRUwVErSReZOARJ4kLwgjc=; b=dno8OynyEDOZSdS8g/F1kOJ57x
	+yaVEWA5QpMwsVq6S1AmJA9vLbeQRgw9qgvzCsKhO230xVhdX6+t32LlWVKcB6FIjWpsSfuwMSvkg
	0ZHCwyODs5kDSF95BuFUVmNuWYE9xLc/KL0114R54PlZboWzaTrxCFQBBfLqruygjW+c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHGvv-0004dc-GZ;
	Thu, 15 Oct 2026 08:35:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xHGvu-0004dQ-Gq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 08:35:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tYUrE8fehM3iGmpifaSflPWbnfTAocKBP2BzOPGoLZg=; b=LGcjIJwtdZESgZsEaVWwtqw/Y8
 Oq1CziRgh2yu52rZqSTdJbnWcy8JfhATZsgWoOB4k6QhxUGBU9T41tTcK+JKf8kuf8NTnVfBZ/K7R
 PwHnGAq9Ax7TqiuWM6LqAYQaBdnLiSYiyFt7VVw68W31wCYFK6vjdvahDNQKHyZ36ajU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tYUrE8fehM3iGmpifaSflPWbnfTAocKBP2BzOPGoLZg=; b=K
 Uid5cGWUEJlCtKPP9ibYaCGaGMcG7Dkk/9xHLWBUIyYX+28/pn1iOOgz1mr/Xuh710XSDPti1y3hr
 72QaktepXb9Gg8eg+ti0mmWLEItvhoOEceI5FAeSLVZ9BLI13Q+bSQ+8PwFNGLuFH/5SD57U8ZjCB
 5iYv82quk2AzK26Y=;
Received: from mail-dy1-f182.google.com ([74.125.82.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHGvs-0008W9-JX for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 08:35:27 +0000
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-35c76e9614aso3238568eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792053319; x=1792658119; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tYUrE8fehM3iGmpifaSflPWbnfTAocKBP2BzOPGoLZg=;
 b=aRRB8ttuQD7lKBWyy5Z/bqn4Kz4iBVOKEO8oALdlw3TcJOJoyoe+xk983lm4C43uy0
 FmhpkKMuB4uETdMxzX5SqKPHTFEvcScMpktvll67HuDDKp4n6E2eD5sEe/aVdo5PuNoX
 bWMpXxjX4zq9EyBKOhvjoZnzlQxZQ1jj1ecMKOP4UbKcblxIsaPyI7UtE0qUb60sKkff
 nxo8DKO9Ilfbo8TW4n3ytrNiabVnigJJKPcfeYoaWnWgv/I5+MSfuG8i6NCByviHkRXt
 omWNI7QdrpG3iGNmbplUhZ+HlCKFxp7DWmR4Y+PAfWXt+DC5UCl9zi1qBRawUX5QHUc7
 PEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792053319; x=1792658119;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tYUrE8fehM3iGmpifaSflPWbnfTAocKBP2BzOPGoLZg=;
 b=IFhiVyhklUEjkWf9jUb4w3er7Fe2LIDqeeYVIovpMxGILIxjj6w7jabWbS6yTBjoCM
 aJn+0XUtN91uSVt4eEQ6PNmGZc5R6HCrLoq4Nb6AjCtcfaZEHhQhyLiE4d9x1oLonnGO
 I1K5HSq5I1cSoaV6CkVCHlMmBmawEh3jRpnSbYzhaN4tiUBVks/ISQXVx55TtY0h5O5H
 ZluYGUQ0TIo8dRZuEmnX09xYV5lxpW/fhXZ8aC3TawKQNU/azl/UCucrgiBJx+cux/NC
 cIExmWCIaa//TVoK1WDIJf3FCmUIl7uL2a/tFyXLp4etq9jY1U+9HE1v9sWBBaZnR9G7
 tjhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFG97waBXOt0uCDDYuIiFMywbjhd+SKimk1XvNNKxDmG3LBT2/Dcnq9o7ajsvOuRb7qOUEHRdzS5+pRqu2OdUX@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJquSXRaPhcyIhOXAzNgKLo/FyxdumalRwa6MGmZgnFazoqxLPm
 JD+uK7di7nRvsSeO5uA0Isokjr7kC8M+IOgj5a2rVE64GwmUS8+3MWL9
X-Gm-Gg: AYBFou33EaQHVA+0ebPTqjBCJso+WPtDZBY0i+523/9275u+6vG0ZYLtBTJr/1xmHV1
 CjllkFrxzpGwOtPxJkz89jX/9cn2DOh3+OJhJWPZ8jsebSZgHKF8Wu0fFj7Vi1zMaYrgrCzsmwX
 M8w9kti2UHqJwfySoUG4yTgHSZs0bWMto/klyi7CP+F2gBehq4U/Jh565w5uxIqtX9UJ+PJDSbf
 75qsYpsQUb1q0UliCEpG/jtXPSmEJVjuSfVDSQeMI8sBXx5T1mq7z4RUcFQ0URNw7uUucDB0ig8
 O1KeSjHdTI4Ehq9G6XALSU+u51zxizz7W+mY01IJzA9U9Nb8poubuW+5sOwxAwm7yfyngOW85hh
 uXvln9p22zwmeVkI4bVRJUeT5Xv5VK/7jRQzcaVUoNvCQqmh1GiBlww/jdZx8le87TLJCE2P7Mm
 Ad9tPmOG9+raaEs5Z7J3yMGT1vcanoblnZJ6XxyznxNNgd4Dd0WIKjrkg6mnYMbBJ7Ag6PgLHCq
 0WBrBqnLOPAJLNUPmIJ5JxWvnNuHgOrpHV4
X-Received: by 2002:a05:7300:e9d6:10b0:354:1db3:674e with SMTP id
 5a478bee46e88-3541db367f0mr26577812eec.6.1792053318741; 
 Thu, 15 Oct 2026 01:35:18 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d20dsm64539101eec.12.2026.10.15.01.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:35:16 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Thu, 15 Oct 2026 16:35:08 +0800
Message-ID: <cover.1792050467.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1xHGvs-0008W9-JX
Subject: [f2fs-dev] [PATCH v3 0/2] f2fs: fix online resize state
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
Cc: Daeho Jeong <daehojeong@google.com>, qwjhust@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, Qiuyang Sun <sunqiuyang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Online shrink changes both persistent SIT state and the geometry used
by pinned allocation. This series prevents old state from surviving
those changes.

Patch 1 drains the SIT journal during resize even when there are no
new dirty sentries. Its code is unchanged, with Daeho's Reviewed-by
added.

Patch 2 now consumes the reserved tail as sections are removed. This
keeps the pinned boundary fixed while shrinking within the reservation
and limits it to the new main area when the reservation is exhausted.
It restores the old tail and boundary on final checkpoint rollback.

Changes since v2:
- Rebase onto current f2fs/dev.
- Reduce resizable_tail_secno by the removed sections, down to zero.
- Save the current tail after freeze and restore it on rollback.
- Document that online shrink consumes the reservation.
- Retain Daeho's review for patch 1; request a new review for patch 2.

Wenjie Qi (2):
  f2fs: flush SIT journal during filesystem resize
  f2fs: refresh pinned allocation boundary after resize

 Documentation/filesystems/f2fs.rst |  3 ++-
 fs/f2fs/gc.c                       |  6 +++++-
 fs/f2fs/segment.c                  |  2 +-
 fs/f2fs/segment.h                  | 11 +++++++++++
 fs/f2fs/super.c                    | 15 ++-------------
 5 files changed, 21 insertions(+), 16 deletions(-)


base-commit: e455328a66a5f4827d4ba96acfe50dbbb0e13b8d
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
