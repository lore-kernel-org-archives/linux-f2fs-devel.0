Return-Path: <SRS0=KzLc=MG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C885C07E9A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Jul 2021 12:44:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B1B613B6;
	Wed, 14 Jul 2021 12:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B1B613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m3eG1-0006Og-NE; Wed, 14 Jul 2021 12:44:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <h_ayguen@web.de>) id 1m3eG0-0006OL-D2
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Jul 2021 12:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Date:Message-ID:Subject:
 From:To:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YQ2GdceBpdmkAwqdb1XtWBA2HNPELY/igi7ARzYBRrg=; b=eyZ+3h0bFTmM/vOdAKos3hPHJZ
 rGD8qNpaEB7cZk9aBFu+559c+oXed5tgeAsThIAhADyhVS0KNyI0sJQykwoqZ/LrM6igy0H86G2W0
 TtMwOa/Gx2XfdzB34lPBwznRR0B7gboRhSlPyfdjml/++i85l2VSewbVbux49VFjgMwg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YQ2GdceBpdmkAwqdb1XtWBA2HNPELY/igi7ARzYBRrg=; b=c
 L8o9uJJ1jaCuBf0HjAJM2rBm1T2IQRcZ0J1QNDNcXSyaicBBbPteTFAcAJjybRCUler78fs/botwQ
 mx/U+bgHOqT3jwpiRBepmvQDIF7lEOBFV5BAgWJ2TAm8OaVJFqb2nGnn2TMmqFyrx5gFmUq+CKrrD
 0W36zneeiYMDYAs0=;
Received: from mout.web.de ([212.227.17.11])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m3eFp-0083Va-6U
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Jul 2021 12:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1626266675;
 bh=YQ2GdceBpdmkAwqdb1XtWBA2HNPELY/igi7ARzYBRrg=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=XUjaFAogfw2+MfsGMab1hlTbjsyyQS3+DkyWc+80Brb1ubxQ4T1P0IaqEAyL/tKzH
 XwLezvSt09XX+T/tvq2mW5/+yfYlmPSYmIBPa7uLHOqzuW1FDIJdaqGAJVI6W65Mja
 +cvma2bWubFF6niUAbx1xbyOEivGnf7gF6yxvZq0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.59] ([149.172.203.223]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWi5i-1lfODz0qi0-00X3NJ for
 <linux-f2fs-devel@lists.sourceforge.net>; Wed, 14 Jul 2021 14:44:35 +0200
To: linux-f2fs-devel@lists.sourceforge.net
From: Hayati Ayguen <h_ayguen@web.de>
Message-ID: <d1a34c8a-167f-1cf1-c272-026686ac2f22@web.de>
Date: Wed, 14 Jul 2021 14:44:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:RhLGg3ZBkbKdi3p2uldLaM5hXxv3ptBbtTgFKiK4zje1MQPaWEK
 ZP1uF51V6gRde2p/Mjr75bLCWWrj7mRKAXEcbi3guv6Ydmw0zlWwexAQEHx/4la3dkli8sP
 2zJmTXWPAgaAHvywCIn5UUV5v7oVK0g99ygMiA53SRU2y256LrJZWBW9DokV7+pCIwUvjrA
 dwcsYSfBl9Rr9093kVPbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HmMuj7/VDfk=:522S7qcvmIyMEZRxT/URqz
 vNbLru9sqxDrmCtCGEIRz33Jmf71hmhYZ1zFZ+BpEj6F6/NIgpoLR+yBtiWjUBPZcuE6WIHDV
 aIe2hE67ttBVpXjsaISv+/HNx3L8b4uxhpEi64st/+p4M9CsxIOhNXakBWitLn+a1Ft9wEpS5
 zjXw/zINVMjvjd6derLZTMOS3UDhbHTSIxwlizJnaeDzgglomfsGYymiIXCredmLJb+haGyg9
 JErjVXM/rbcGjnWpCwp/PBCSPYBk5PAYIV4cIHlI1sjKdfSpcJQBsjQH4I1uTH9Itwqgnn8g6
 bJ7YaGtAyL2eOen6extE6BMraV9AoPm3utJyKP1FoB+M5Ql/pmGQMGFFp0iw97+okBe/8A0g+
 opAFMif4xh3WVfHefdlWbvUGwDEZ/n/SbLfN4ijCHR9A0HbKtxkU15owVH1U3SKS9k8T17b5v
 O0kFLTP40mrw65MvRmyZSBeoXZn2sMEd2Y/Rwi9bfgrSb4fLed+WtBArAuwAO+p3W2OkCOwLS
 1adwjEM/FuPeEaJL6vbGwhLNh8vF/n/gX+kVtEe9mVuAwuhayCTGbGhCz/fhlaMWm95tZ6g33
 PF1vufJTTGNuFVzyaZhC7XL0X+7X3MiFiC/0WkSt/ep8rfzu0ZfgOLFS6uXGE2w1R/OZalcDD
 ziRgQ7qY6CTk8GlDKcFXR1m2nCKVPt8T3EQj3RBM9fe5dHmrq79PUI+DAcxXL+K039NLLxRcc
 y2mWD+LUqYzvo9YMgCZz/X3tea+TZ4XrChhxs/i1b/BFgeZFR0oNK5UOnhf9nb2zPferrnPzJ
 6VK0nxKAPEHryFx5X4HksXGOw20KcEOvu53QqmPoDddJE2yE+Ray3y2/Avw99QsOsYthDEb1s
 WzvVt5QthVn1Vqj4tfPb1C89Qo4Uu5ByC1aQJZCuB76lgQjOfFlHTYmzfynBdlU+/FZnO1MJz
 xtf6X3EIsovuZvf8eTF1tBEwMN2yXDHKWiFAIt4FAI3k0MMW1hYaz1Ph9hkyQN3fwUP9wa7EJ
 f2IcOzScI2YvnIMErAVDmH4eXycrs4wqSwTlcVCbUjE5jLhrpx15LEOYyeWkKn1guq4kgY7IL
 nilhti91M4HgGKddKXo2Wto5O2QZSQBZr20
X-Headers-End: 1m3eFp-0083Va-6U
Subject: [f2fs-dev] tests on (and howto increase) lifetime?
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


Hi,

[ probably i'm wrong in this mailing list .. but this is best, i could
find. also i tried to search archive .. but couldn't find the right topic. ]


i have a logging application on raspberry pi (3/4) writing to an
usb-stick or sd-card through an usb-adapter - not the internal/boot
sd-card with the operating system. see https://groups.io/g/fmlist-scanner
some are used mobile: in a car or backpack.

it's writing approximately 100 - 200 kB data (few new files: some csv
and a zip) every 3 to 5 minutes. write speed/performance is no issue in
my application. the raspberry pi's tends to freeze or reboot from time
to time .. thus the data should be safely stored .. it's sync'ed after
every write (of the few files).
daily data is summarized, compressed, uploaded and moved into another
directory.

vfat formatted usb-sticks usually get broken regularly in some weeks to
several months.
that is why i meanwhile recommend f2fs: looks it behaves better - so far.


are there any tests (scripts or programs) to tests the life
duration/cycles of usb-memory-sticks or sd-cards independent of
filesystem? i would be interested to compare vfat or some other
filesystem vs. f2fs.

is there a safe way to detect write errors - independent of file system
- deactivating the system's cache buffers when test-reading?

are there additional strategies to increase the life of sd-cards?

kind regards,
Hayati



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
