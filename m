Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7590EEB64D7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Jun 2023 16:29:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qC0iN-0002aY-DV;
	Wed, 21 Jun 2023 16:29:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <michael.opdenacker@bootlin.com>) id 1qC0iK-0002aR-0Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Jun 2023 16:29:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:From
 :To:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=94by8Vzj+3BwDsME0JPLcnpxf/5l/bkSfoIb8OZTb7U=; b=Rq/FcP7tF+qunzOVLG6kutJcla
 7OD2Rr+ex405X8cOdM14sB7hMZ4S62FskJA1NDipoVNO0p1j2I7asou/75kmVfOvIbgYze75zfucW
 lD+hq0Xn8kK2acxGa1CvJUTZkxbce5dIAVbNq4jk0mOn1XhmJgOVwHOX9FFtRbffRenM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:From:To:Cc:MIME-Version:
 Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=94by8Vzj+3BwDsME0JPLcnpxf/5l/bkSfoIb8OZTb7U=; b=H
 d8/AkIcKlMQGclnxiQoNahbSeACKEeS2sGVkX1u3FoB7QCU9X8aDb74ABtz04c3pdxoAwNCLnEYVM
 8at7hVm6r3a6LKx1U2M9jMWWF3cfQQGR/p/+olwEQGBDk8T1Dwbf5Dl0UB9nnNYLsvYGMFAKf2Y7H
 lPpywsDLoI0xPt3A=;
Received: from mslow1.mail.gandi.net ([217.70.178.240])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qC0iA-00AmY6-N8 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Jun 2023 16:29:48 +0000
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
 by mslow1.mail.gandi.net (Postfix) with ESMTP id 8582AC15DF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Jun 2023 15:48:15 +0000 (UTC)
X-GND-Sasl: michael.opdenacker@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1687362483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=94by8Vzj+3BwDsME0JPLcnpxf/5l/bkSfoIb8OZTb7U=;
 b=Bf/XTgRqLpT71tG6P0KubX5hyYuzTYrbRy12S+/gNxNhVi3lAUUdcenoBvzRVkZ3D0tZxE
 7zwoiqmKbYVL9H7q7qQqe/v487nwxhQSzSf7VAt7FXMZB9CHhDYtxb8nnWwyCQzSeDAWLR
 b2yceqb71zVcebFAXEfOgLze+YBfKAuV4sHDsz6Cro338X5xzimKCQJDEmLbR/gS42z0/d
 IZUk3RAuMy/IFXH0VBBzJxgj4eRQJ4iw8jSKfeYszxvGQnSVp0iNqlRrri/B/8SJzDE4QN
 Ms8O3CBrBo2aGN+8fLs2jS0CKZg5tI4FlwXSwk+UUVcGtiYqNRpjwtsJm08qAw==
X-GND-Sasl: michael.opdenacker@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15438240002;
 Wed, 21 Jun 2023 15:48:02 +0000 (UTC)
Message-ID: <7cea747b-0255-669f-fdfa-932f275d09c7@bootlin.com>
Date: Wed, 21 Jun 2023 17:48:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: linux-f2fs-devel@lists.sourceforge.net
Organization: Bootlin
X-Headers-End: 1qC0iA-00AmY6-N8
Subject: [f2fs-dev] Trying to use compression options in f2fs
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
From: Michael Opdenacker via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: michael.opdenacker@bootlin.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Greetings,

I'm trying to compare the performance of the various compression options 
in f2fs versus the default settings, on an SD card.

Here's what I'm doing:

  * Creating the filesystem:
    mkfs.f2fs -f -l data -O compression,extra_attr /dev/mmcblk0p3
  * Mounting the filesystem:
    mount -o compress_algorithm=zstd:22 /dev/mmcblk0p3 /mnt/data

I'm running the tests on the Beaglebone Black board with a single-core 
1GHz ARM CPU, using Linux 6.3.6. I'm using mkfs.f2fs 1.15.0 
(2022-05-13), built by Buildroot.

However, I see no significant difference in terms of disk usage, read 
and write time, typically when I write and read an ARM root filesystem 
(from the Raspberry Pi Lite distro), compared to creating and mounting 
the filesystem with no special options. On Btrfs, the differences 
between compression options are really important.

I chose zstd:22 because I expected it to be the slowest choice in terms 
of compression. I'm expecting all files to be compressed (if they are 
compressible) by default.

Am I missing anything?

Thanks in advance,

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
