Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C7AC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  5 Dec 2021 17:37:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mtvSW-00064H-Ds; Sun, 05 Dec 2021 17:37:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <antsub@gmail.com>) id 1mtvSU-00064B-Qw
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Dec 2021 17:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uIrTZmOU+C5rbvCLn3V6mx/wbhWLhq2rvdHPALN7j5U=; b=RM1kW12aoghRJZtiMI6jKv5QV8
 mV9Omq+hq27HnhRkRCEkmU+6W6RFp9gb0FlhFDG+TAidsxnqjKFgAaYIJGwWnACx9yEOUOPTm+w3J
 EijuXSVDJQ1g0bRTZwC7zUd46YncHFIn9GjjSGbRGffrV5SI7soWluqeQxvf8P2EyyAc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Message-ID:To
 :From:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uIrTZmOU+C5rbvCLn3V6mx/wbhWLhq2rvdHPALN7j5U=; b=O
 OsdNaGy67VsqIn7kO9fT9Szxa56jd0X2xpWZLXUATrSmmtxWwdki+CPmsGF7BmqJIvXWU+PVEDCWc
 wZhYosdxo3netGwlRwkcuY/rd+dlvMp/+CuESDLnIJnff4QAqaXkQiF1YCGNHhvaH1qpeX9GfSN23
 WUeP6P/uqxEL9Xwc=;
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1mtvSU-0005QP-8P
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Dec 2021 17:37:54 +0000
Received: by mail-pg1-f180.google.com with SMTP id r138so8212226pgr.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 05 Dec 2021 09:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:message-id:subject:mime-version
 :content-transfer-encoding:content-disposition;
 bh=uIrTZmOU+C5rbvCLn3V6mx/wbhWLhq2rvdHPALN7j5U=;
 b=qPeKHDyeT9y9Vlyos6WF4zIs2e/Sh+0RF3/AH/3o8d4pA+5InUz1TrY1HsnA3mNGyK
 BKKIrgYaTRRM6xfKO+ZXlVmxyPmSTRtl4a9iznDpbv5byCDpruNDFuzmUEjfpFusgOmD
 DNANcxphqvjt9ob6EIhWNjLvHsdCeWupW3KTh28VBRd2AzwLGUY7kF0TYswJhr4RurJH
 XJ7xxPOZFTIa0ImIwiCRCuMbBznL7zoO/AKAQV4XPtFOnnfTxReC1OyZCiGGk6MItYq6
 rDyuZ2oOB8f32m83YxzD3Wl91bTvWlYDL3Oclr6S17VTdWDZLHaz04ao0yqRykjg2G86
 xAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:message-id:subject:mime-version
 :content-transfer-encoding:content-disposition;
 bh=uIrTZmOU+C5rbvCLn3V6mx/wbhWLhq2rvdHPALN7j5U=;
 b=1cV9wVHMh2Xd7ht39tWsSYh5YNutLn8Qm+ftDALaTVFWOsv3SxWSvvCYSBQhaj5gWV
 7/Oe4Lxvle2lyBOrFo9CBz4yqX19fG+J215ClC2Jm5gJvnTVWS8o2BYuSeUWrBXW15Yn
 zGrMOANGs5ksmmoTgyFRja8bheBo2Ck2Cn+FBnF9Ws+Jmdi3dAr2CU+R5IyeSCcU/OYw
 b4SIsnWXeZHLyh40jM0PL/5Thlh7fJ5iqQa+Eti2hAH4n0F0dtrp6KV/z01cAHP1qZBY
 FG6FjiaDAFXly59pz5wfKA+JukS29Si53P4a/49VYPVia0ZMmsvWKGBhH54Y404JOloL
 sQfA==
X-Gm-Message-State: AOAM532Bkbb8bBGk9xX/zRheB+kYjMxslxe95ZXkX0G1docVQgWE9yLu
 ECHR/c9Oc2vNs6F1MLysKa7ANNK7O9Tvbw==
X-Google-Smtp-Source: ABdhPJybtZX+6zmRF37ubGcZ9d9DPuv8d30htNlDGvnximWh/QQ/uv/al6iifZebTGxX+yD5cOfJ5g==
X-Received: by 2002:a63:455f:: with SMTP id u31mr4207422pgk.426.1638725865098; 
 Sun, 05 Dec 2021 09:37:45 -0800 (PST)
Received: from shadowfax ([49.204.139.191])
 by smtp.gmail.com with ESMTPSA id d17sm9032062pfj.124.2021.12.05.09.37.44
 for <linux-f2fs-devel@lists.sourceforge.net>
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 05 Dec 2021 09:37:44 -0800 (PST)
Date: Sun, 5 Dec 2021 23:07:42 +0530
From: Ananth Bhaskararaman <antsub@gmail.com>
To: "=?utf-8?Q?linux-f2fs-devel=40lists.sourceforge.net?="
 <linux-f2fs-devel@lists.sourceforge.net>
Message-ID: <00F7D971-AEE1-4EBC-86AE-CA9BAB947D96@getmailspring.com>
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1mtvSU-0005QP-8P
Subject: [f2fs-dev] Multi device fs and udev
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I have a multi-disk f2fs device, and when I run lsblk, it shows the fs
only on the main device.
I'd like all devices to show up with the mounted fs like btrfs
multi-device arrays.
I'd also like udev to recognise that both devices are used by this fs.
Right now, the second device just shows up as unknown.

I'm intereseted in adding this support myself.
I'd appreciate any tips on where I can get started with this.

Ananth


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
