Return-Path: <SRS0=jKbZ=25=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E3BC282DD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jan 2020 18:45:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000D42067D;
	Wed,  8 Jan 2020 18:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="iE0QR5eg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="RrV7m2VU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000D42067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ipGKq-0003On-3k; Wed, 08 Jan 2020 18:45:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <piergiorgio.sartor@nexgo.de>) id 1ipGKo-0003Og-F0
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jan 2020 18:45:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oCw6uQQEhudOuleCQDp30XdPuhglQuJFgurblsCoo/o=; b=iE0QR5egcA5FMdwWwfnoeoIXEP
 yKs/r94y1frwB6zHN3CIsy/0Tu6NDS9wy7H7QBiLigxdWbklBdPblugLZoKBbGvTS+5Yr8t9RV1wC
 YAtABvOr+WOzpJqTTSWuptWfbzxSPoe2QycVqa+4VhtTpVA822HG/2RaW5QOeQBD5MPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oCw6uQQEhudOuleCQDp30XdPuhglQuJFgurblsCoo/o=; b=R
 rV7m2VUNLa+7UrDTMpHgWUztj4GwyZKJtQCpdDG9jclP9ZbZuksQKARBQU2IgAR5nVv743b8mFo6m
 THU+sF+Ia2/8dWpnUNGickLfzI8U7qsd8gxS0cYSFqoZINGhtX1kxUQ2yl4asji2XTakBNsqPdD9i
 gb2MIXfytc2WUu0I=;
Received: from vsmx011.vodafonemail.xion.oxcs.net ([153.92.174.89])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ipGKl-00DhIA-QR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jan 2020 18:45:38 +0000
Received: from vsmx003.vodafonemail.xion.oxcs.net (unknown [192.168.75.197])
 by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 786BB59D19C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Jan 2020 18:26:58 +0000 (UTC)
Received: from lazy.lzy (unknown [79.214.221.251])
 by mta-7-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 5546E5399E4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Jan 2020 18:26:56 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
 by lazy.lzy (8.15.2/8.14.5) with ESMTPS id 008IQtBt010412
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 8 Jan 2020 19:26:55 +0100
Received: (from red@localhost)
 by lazy.lzy (8.15.2/8.15.2/Submit) id 008IQt2U010411
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 8 Jan 2020 19:26:55 +0100
Date: Wed, 8 Jan 2020 19:26:55 +0100
From: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To: linux-f2fs-devel@lists.sourceforge.net
Message-ID: <20200108182655.GA10257@lazy.lzy>
MIME-Version: 1.0
Content-Disposition: inline
X-VADE-STATUS: LEGIT
X-Headers-End: 1ipGKl-00DhIA-QR
Subject: [f2fs-dev] TRIM issue
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

Hi all,

I've a small box, with Fedora 31 up-to-date.

The system has LUKS + LVM + f2fs.

Since kernel 5.3.16-300.fc31.x86_64 the fstrim.service,
triggered by the systemd service fstrim.timer or from
command line, does return an error:

Starting Discard unused blocks on filesystems from /etc/fstab...
fstrim: /home: FITRIM ioctl failed: Read-only file system
fstrim: /: FITRIM ioctl failed: Read-only file system
fstrim.service: Main process exited, code=exited, status=32/n/a
fstrim.service: Failed with result 'exit-code'.
Failed to start Discard unused blocks on filesystems from /etc/fstab.

Note the following:
1) Both /home and / are rw
2) LUKS and LVM allow discard to the underlying device
3) An other PC, with same layout, but ext4, does work as expected
4) kernel 5.4.7-200.fc31.x86_64 (latest for f31) has same result
5) fstrim -vA or -va does not return an error, exit code is 0,
but it always says 0 (zero) bytes are trimmed:

/home: 0 B (0 bytes) trimmed on /dev/mapper/fedora--server-home
/: 0 B (0 bytes) trimmed on /dev/mapper/fedora--server-root

6) mount shows that the f2fs mounts have "discard" flag

So, I suspect there is something with f2fs which somehow
confuses the trimming process.

I had a quick search, but I could not find any other
similar report, except one about systemd, but that
does not seem related.

Any idea? Suggestions?
Debugging possibilities?

Thanks a lot in advance,

bye,

-- 

piergiorgio


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
