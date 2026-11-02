Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F965606B0F9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kwxE7Ez0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Rl9MjMGB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=g7tpJHHv;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=or9ocfnt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lfYhUUj9gnYAr2AlKoiYgVGqLgrByZABagOlUKsBSw8=; b=kwxE7Ez0R//iQusNB0YdeHHk9j
	Vr0ydfUU2GyNDSTDJdJWnG43XMYar4FgAvT6NwouC+OyytOx2iuzRLyGQZmnm3G6/IsggCHIfnT5n
	ymlsNP3hMxSKcw3nCI1o/s6qhp3+T2sl7m8D+m2BsCJuPvxNujE6XjprCdQXV2h2L+Oo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNv36-000000002iT-37Gn;
	Mon, 02 Nov 2026 16:38:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jaegeuk@kernel.org>) id 1xNv35-000000002iM-4956
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:38:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+EjIng1wmWPZLMPlxavzBwtkLK4d8SnEFxgxVSFNl0E=; b=Rl9MjMGBUxx5CcPYGJpOGslYSm
 GmNgJJL9+rVdoYCZuSFX5qo9hiFv2+4as9xbi7nf0/U6aGMyjWhnVGMLM/JX9lJmVfYrI6oNgbEtl
 fmoIWqV03pvBPVbi5g8XNOACZhJZ3xeByaBqRwvroBKj4kLs1LE6Cp5gZ9eUZnaDOGe8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+EjIng1wmWPZLMPlxavzBwtkLK4d8SnEFxgxVSFNl0E=; b=g7tpJHHvbZVzemEBeSqhSJMeVr
 Jq8dn4WbxtRZLvE6ZcfG1SczQcF1naPaXBHPoLKHHque/3joevnXiR+h2PIv8pljLLzCPOe3b9Jvy
 dInRZbQrCDBJzs5icQBVjdkhui9OQHzHArUAkYSR8GQzgyJb0kyCz6xEIqZHbYMfcIh8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNv33-000000005Np-1dtx
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:38:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0FAC340F08;
 Mon,  2 Nov 2026 16:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8551F00A18;
 Mon,  2 Nov 2026 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793637491;
 bh=+EjIng1wmWPZLMPlxavzBwtkLK4d8SnEFxgxVSFNl0E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=or9ocfnt8lZHMXQBMd7fdzy56Q0zdhckeQteDMj/Z00g63zvPIuEZlrK3mlqpBYRn
 Gp+5UFXk6nYBUliHkNTPq6ogvkSr9W7PM8C6zfDvc7KCbaU9si+tDTGvAJMeELPNyU
 xPoaCe09coNxTOpg01JJ5rUXmolhXiJw6h+rlklbKZvDlygruAkMM8IBi9WwFR5x1M
 s6TWe1BdIXNCw3KX7w/wMIbObWQJKzwF/qQXmjdg+7GBlCV25PWifXkfA9ulKPCul8
 yKgS1EcJ8IDHe45H4rVgNOaNMow6IntOihuJ1QnMHsY7S+o8qFpZs5t949K67vbHoa
 OOJfPcsh/BDkQ==
Date: Mon, 2 Nov 2026 16:38:10 +0000
To: Federico Amedeo Izzo <federico@izzo.pro>
Message-ID: <aui8cqosL0gDFlhF@google.com>
References: <DMJR2CYAC8C3.36W5SE92C5OL4@izzo.pro>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DMJR2CYAC8C3.36W5SE92C5OL4@izzo.pro>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNv33-000000005Np-1dtx
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Federico,

On 11/01, Federico Amedeo Izzo via Linux-f2fs-devel wrote:
> Hello,
> 
> I am a member of Nura (formerly postmarketOS), a Linux distribution for mobile
> devices. Our system optionally supports F2FS as filesystem; developers can
> enable it instead of the default ext4 when building an image for their device.
> I noticed a regression on fsck.f2fs/resize.f2fs from f2fs-tools 1.17.0
> resulting in a corrupted filesystem making impossible to boot a fresh Nura F2FS
> installation.
> 
> Our setup to install Nura on Android devices is to create a small image 
> containing a GPT table, a FAT32 EFI boot partition and a ext4/F2FS root
> partition. This image is flashed on the userdata partition using fastboot and
> gets resized by the initramfs during the first boot to make the rootfs use all 
> the available space in the userdata partition.
> 
> The fsck or resize operation is corrupting the filesystem, resulting in an
> assert during update_data_blkaddr(). See the commands we use in the Nura
> initramfs and the corresponding logs at the bottom of this message.
> 
> Note: We recently introduced the `-F` option to run the resize
> non-interactively, as we run it in the initramfs during boot as described above.
> 
> I hope you can help us solve this issue and restore the F2FS functionality on
> new installations. I am available for making further tests or investigations.

If possible, can you share the image that you're trying to resize?

Thanks,

> 
> Thank you very much,
> Federico Amedeo Izzo
> 
> ### Command: fsck.f2fs -p /dev/loop0p2
> Info: Use default preen mode
> Info: MKFS version
>   "Linux version 7.2.11-arch1-1 (linux@archlinux) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri, 16 Oct 2026 00:28:58 +0000"
> Info: FSCK version
>   from "Linux version 7.2.11-arch1-1 (linux@archlinux) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri, 16 Oct 2026 00:28:58 +0000"
>     to "Linux version 7.2.9 (pmos@build) (Alpine clang version 23.1.3, LLD 23.1.3) #3-postmarketos-qcom-sc7280 SMP PREEMPT Sat Oct 17 01:53:13 UTC "
> Info: superblock features = 828 :  extra_attr inode_checksum sb_checksum
> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
> Info: Segments per section = 1
> Info: Sections per zone = 1
> Info: total FS sectors = 700160 (2735 MB)
> Info: CKPT version = 39bb7788
> Info: Casefold: linear_lookup [enable]
> Info: checkpoint state = 145 :  trimmed crc compacted_summary unmount
> Info: No error was reported
> 
> ### Command: resize.f2fs -F /dev/loop0p2
> Info: Force to resize
> Info: MKFS version
>   "Linux version 7.2.11-arch1-1 (linux@archlinux) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri, 16 Oct 2026 00:28:58 +0000"
> Info: FSCK version
>   from "Linux version 7.2.11-arch1-1 (linux@archlinux) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri, 16 Oct 2026 00:28:58 +0000"
>     to "Linux version 7.2.9 (pmos@build) (Alpine clang version 23.1.3, LLD 23.1.3) #3-postmarketos-qcom-sc7280 SMP PREEMPT Sat Oct 17 01:53:13 UTC "
> Info: superblock features = 828 :  extra_attr inode_checksum sb_checksum
> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
> Info: Segments per section = 1
> Info: Sections per zone = 1
> Info: total FS sectors = 700160 (2735 MB)
> Info: CKPT version = 39bb7788
> Info: reszie wanted target FS sectors = 55974510 (218650 MB)
> Info: flush_journal_entries() n_nats: 25, n_sits: 0
> Info: Duplicate valid checkpoint to mirror position 1024 -> 512
> Info: Write valid nat_bits in checkpoint
> Info: write_checkpoint() cur_cp:1
> Not enough space to migrate blocksTry to do defragement: Skip
> [update_data_blkaddr:2527] NAT and SIT is inconsistent: ino: 3871, nid: 3871, blkaddr: 838754, segtype: 0[ASSERT] (update_data_blkaddr:2529) 0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
