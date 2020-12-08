Return-Path: <SRS0=Ksgo=FM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FD2C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Dec 2020 08:27:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775D023A5B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Dec 2020 08:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775D023A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmYL8-0008BL-OB; Tue, 08 Dec 2020 08:27:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <robinh3123@gmail.com>) id 1kmYL7-0008BE-RI
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Dec 2020 08:27:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SLvXqcuRAnwClpMeWqo0QZa4oVJ4xTd0hMNtnI1KgKw=; b=DnjxwUytHNF1JrXgB/6gMwDeFY
 RtTlbZukAdYSE+OACPBNBKc78uqOctermsAYtCAMcVpVAD4E729YAxTJd3Lvb2i2aiHrD5yQxNUn2
 ESOybtmnd//ua1KMIPwXVzXn3msTe3MTLSsumhXJksPPunk9wzMsoXvzfy9/Ah575D5A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SLvXqcuRAnwClpMeWqo0QZa4oVJ4xTd0hMNtnI1KgKw=; b=X
 OWmE+ibe9QIzaf4N6tGjDjyGuhqWUnzOxsm4t49dbfiZLtIh1vBogqnl+dFffXU8RQYyt9joAXNAS
 z/x2gPRZ4ka/j/H3pLSPQnkuIxwJIqBbbtvpLf7mDLw5BSi7tVcOeGEVv4RCCXItqQRK11mR8/xcn
 JdG3LGDcZ2tbGjck=;
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kmYKz-003Aqt-Lf
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Dec 2020 08:27:17 +0000
Received: by mail-pf1-f170.google.com with SMTP id d2so9337119pfq.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 08 Dec 2020 00:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SLvXqcuRAnwClpMeWqo0QZa4oVJ4xTd0hMNtnI1KgKw=;
 b=LnOo3u7pKqtXdNliB6dRqdNlwTv/ezGz57B78Rynd+xyI+nwouKYfb9nL9tjiy+DFH
 9G3l1SwfW2VU5p5QbyvCwCBNNUgtNV4+qjNGOo9Gfcux1yCOZv/FkfMf1mm42doOAGK8
 RI8ihDDap1YziJnjM01AvdT0M3AovwVFzxMAoAu9Sg2TzC3Cd4EuyseYwzHqlE9AvYJI
 EXaCVvVrHftxVTirhIj7+ccUw7bXYjlscWMPH74h55FBGK8qMp5GDJNjfaZujMMGoVHe
 y0o4hU+uiMeP4bsvT/uyh70VPVWTtC662WZxWbL/SGMONHr0U3TT0jVbUUDQjk/DA1ho
 R/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SLvXqcuRAnwClpMeWqo0QZa4oVJ4xTd0hMNtnI1KgKw=;
 b=d7M/OI1K/Zp080cl9/l15LUi/lZ7wgRrq3SNcRNsWK9OU4h8sVM4+ynBEycnc5oddA
 kYPmkz2i1a6ArHAco2DQ2R5PEszBa1JuEWpkbFAF6fHbRqANhEg8CpK6l04J1GuL0C7N
 Z8522PLgeT/4BMXzh0FY9fOTRqSbbsSKU4ApW7iMn7v1t/5LyV7AaoAhSLRv34tNWT4y
 PGWqZfa+xPcSqgBaACnS+Fk87Pb1V3TccQSs8Etu10HGoQrVEgrHUwF3bc9QThNKCE31
 X5eODf7fME/27TH2l2/VMp5OYGG17w2tZm7/FQmIT+y8KBBmy/uxXjVsUICj6AM9a0rU
 7ViA==
X-Gm-Message-State: AOAM531UixZb8NskXx6BPOuyXqU5yzbIOmqy0ESAB+EVISrrXgklIeGt
 FOSRA3Do72lFrqGIndN6bIGsix3Pz9w=
X-Google-Smtp-Source: ABdhPJziOWdNexMuJzJ7EUmZckZaby7roBHPZQUNSQDO2SGtNfj78YApW+l8y98ph/wfVtGutfR7uQ==
X-Received: by 2002:a17:90b:350a:: with SMTP id
 ls10mr3265775pjb.192.1607416023936; 
 Tue, 08 Dec 2020 00:27:03 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com
 ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
 by smtp.gmail.com with ESMTPSA id q35sm2469483pjh.38.2020.12.08.00.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 00:27:03 -0800 (PST)
From: Robin Hsu <robinh3123@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao@kernel.org
Date: Tue,  8 Dec 2020 16:26:05 +0800
Message-Id: <20201208082605.654422-1-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
X-Headers-End: 1kmYKz-003Aqt-Lf
Subject: [f2fs-dev] Please ignore "sload compression support" patches
 without "v3"
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
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Robin Hsu <robinhsu@google.com>

Hi, All,

Due to my mistakes, patches for sload compression support were sent
without "v3" (version 3).  That was corrected by resending them again,
with the correct subject (with "v3").  Please ignore those emails without
"v3".

I apologize for the inconvenience.

Best regards,
Robin Hsu



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
