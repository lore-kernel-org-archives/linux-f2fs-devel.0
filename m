Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF536096213
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bwQtwhKN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dz45/ug/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SIO6CUBN;
	dkim=neutral header.d=izzo.pro header.i=@izzo.pro header.a=rsa-sha256 header.s=soverin header.b=L+hL2IrZ;
	dkim=neutral header.d=izzo.pro header.i=@izzo.pro header.a=rsa-sha256 header.s=soverin1 header.b=VkfqiytD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:Message-Id:Date:
	Mime-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wD7tWFPTI1FtPEm0D3n6Uw1YLCzRM8Wjv156WeoaYoI=; b=bwQtwhKNcYXdES
	VXOATB/biMH9a3OskBXV6gMBbqzH6JzeSVDtgg906GnUF79JOmnYu9T1OYirnDUVwlO9W2em8UGY3
	7yL5tWFiIXwsmay2F9TMHJ05q3Sba1WP6AQXk0T3mEeVHAu6LQwQinppruhw7NBE+dkALfgJHrBI9
	m48=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNvhI-000000001oF-24ok;
	Mon, 02 Nov 2026 17:19:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <federico@izzo.pro>) id 1xNvhF-000000001o7-3euE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:References:Subject:Cc:To:From:
 Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tA6yS6egf4ZKmabtXohaYHvAsvwo9J58qDcIcd6gWOo=; b=dz45/ug/Nu5u0A3+qdgFCo4eiH
 7RWKpdcuJGsdzcJ/hwHtxJ9ddCR2RBT185EqUZo5OlxAx2NJoOENs5UASRgEKCvwoOzHnolJgsccU
 FsBajvyCkbbKB3zqyZS05LNGZ66Wi3Bjq3NLMguIPeULUypsWKMpq0gbTGS7QD9IWzYI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:References:Subject:Cc:To:From:Message-Id:Date:Content-Type:
 Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tA6yS6egf4ZKmabtXohaYHvAsvwo9J58qDcIcd6gWOo=; b=SIO6CUBNeB/EPUmcjk7UJIyA40
 xWBuxodNiT97brGtSUYSDok6KBzKxrjKVPaIvbxPR7EnyqDxWgn+myJ+iNHMEeQ3T5QcdKTJVUDr2
 l3lAAYEOOIYZ7kqr4Kmrrxwrh68sNPzI5/t1SRpButP+k2kCm+QvSqvBfHcRdwnFtYpw=;
Received: from outbound.soverin.net ([185.233.34.146])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNvhE-000000006Qr-1OFG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:19:49 +0000
Received: from smtp.soverin.net (unknown [10.103.10.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by outbound.soverin.net (Postfix) with ESMTPS id 4jJJNZ017ZztVs;
 Mon,  2 Nov 2026 17:19:42 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.103.10.154]) by
 soverin.net (Postfix) with ESMTPSA id 4jJJNY2H0LznRP; 
 Mon, 02 Nov 2026 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=izzo.pro; s=soverin;
 t=1793639981; bh=zGqH16W82mACATSInG434H2uDjCzI/u1eJC015Cypqk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L+hL2IrZrzNv/TYbxRdDMGMEePenCmhCnITl77/STUEgCrrbh7BBVp9Uk0ET1sWE/
 e6SaDk6HZjF9YAvVs2INLJRA+NW67HH/vo862HS89kpNoI1QQ9oafgW9uS9/5wUFzD
 1aHzCbrxDyXSFN+COXmlQ17PXLHdTlPH3EcTRoS3anWQAkenulQ+ttMpbH/Cl/GMKH
 xQyn9kbELzwLa3Kc/ZZq+t8tciRoZ602nX58l27c25bP3ncv1zFaURopWC+4p+39Os
 Ga3AHGtdkHwOeuJ+YU1s3UDzP0c7YoXDTenIj38UBhJe1hpmhHCVmCH58AWRM0bN5D
 vILACKr4cwaBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=izzo.pro; s=soverin1; 
 t=1793639981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tA6yS6egf4ZKmabtXohaYHvAsvwo9J58qDcIcd6gWOo=;
 b=VkfqiytDZqQanyhL4j1FwDEJey4Xn/+frC50M7b8XrSa0On+6aYAav0UJjiJkrhyYuzLhK
 1+m6hLkBdA24c6iFyD/68TuERfjmwVBdnYhiDYmspBuekyQjQcJiJY6nyIjKBpGoIzS1Pd
 3isB3xuPU8AIYA1DJGVJWBnhzGPpERO9JKTWwLN9P5dNhOGdG3Tig5Oof4RUCEZ/rlMIeV
 CmuOx2rsaVSy2H2nXE78qieFk3bLRUrsOuUp1RKyVUFjCECZ5zMtAHNALBl6S/ziM10Iwk
 y2lxvuv+dwe4T9T3ZVPGasyZLdSx1Z3E6iPl5LajBOLA36s7NCSww0VMI2wHTw==
X-CM-Envelope: MS4xfEaej7UEMYKuu7ajQRkTaTIAyn7uiLMDiZTIj4d/RMajLMYEKqe/j1ToRk41DElSsKVmZCjJzOFJr4Uqycgtr3XEJlIrBnLaXx61e9sLw+8f6Xvaeihs
 R3cHPVJ1jH6d+fozC/L9wjA4OJK4id9Q+K7JF9tIX1Yd6cf+Tj2rFnvZJvZXY/yZNqb/YSflfsGFViUJ19P8m07ydxlejZ8oByAtnd0buyXltGcyrNPK9HSj
 bQFiEd5RbyPImIAkHPivKOiT2ZnIxaDaJWDs/PaqV5E/TbeA+2ZJ/TXUX4cXdyZz
X-Soverin-Id: 01a19d46-1fc8-7a6f-9cee-af4a584bcfa1
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Date: Mon, 02 Nov 2026 18:19:40 +0100
Message-Id: <DMKWB3WUHCS8.2NJ6PJ9ZRQQ0I@izzo.pro>
To: "Jaegeuk Kim" <jaegeuk@kernel.org>, "Federico Amedeo Izzo"
 <federico@izzo.pro>
References: <DMJR2CYAC8C3.36W5SE92C5OL4@izzo.pro> <aui8cqosL0gDFlhF@google.com>
In-Reply-To: <aui8cqosL0gDFlhF@google.com>
X-Spampanel-Class: ham
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNvhE-000000006Qr-1OFG
Subject: Re: [f2fs-dev] update_data_blkaddr assert during resize.f2fs in
 Nura initramfs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Federico Amedeo Izzo via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Federico Amedeo Izzo <federico@izzo.pro>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	PDS_PRO_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 2, 2026 at 5:38 PM CET, Jaegeuk Kim wrote:
> Hi Federico,
>
>
> If possible, can you share the image that you're trying to resize?
>
> Thanks,
>

Hi Jaegeuk,

Sure, you can download a zip archive from here:
https://nextcloud.postmarketos.org/s/G3AixpnQSBcMk3q

It contains two files:
* fairphone-fp5-userdata-gpt.img: The GPT image containing boot and root
	partitions, usually flashed to the userdata Android partition
* fairphone-fp5-rootfs-f2fs.img: just the f2fs root partition, extracted from
	the phone using U-Boot UMS after flashing userdata, before running the first
	boot resize operation.

Keep in mind that this phone (Fairphone 5) has UFS storage, so it uses 4096B
sectors.

Thanks,
Federico


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
