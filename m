Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0944EB64DA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jun 2023 06:56:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qCEEw-00039c-V9;
	Thu, 22 Jun 2023 06:56:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1qCEEv-00039W-Os
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jun 2023 06:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VTo+HigHW8+1ffkU52rSZXnRkWtfDxC3rDlCkoyWTUo=; b=DluUoFeTrE/w0Mz3r60Wm/rFvA
 0xPgW+0ZIrXMWjGn+5UMhHcNYn5wUpsDSS10u6mdRBj5wd8lZ3jMztAJjqckdc4W2Zh+SPUSF85Yu
 p7NiwsY3ookofjvBBa4ycJJQ3EXE6oMqNxMS6FCQlG7fu3bLWvzzQkxi6Rz8GRJUQaGI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VTo+HigHW8+1ffkU52rSZXnRkWtfDxC3rDlCkoyWTUo=; b=bcmAqLwV8rjrb1FGkBOb2H7a8U
 fwOc5+h0gbgd7v2peT66IWt2ZJK0pkvLWX4mF3a5SZcPSQFSiLh2JxmGYbdF0cPQpaueTu+OWIpA0
 KNArbJjpZkusYSnOxUWgYtlE1KGz57/G6JuKt9dWj889dJDQwRRTs/yIoYOYIFYGFKdo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qCEEv-00BFwK-JR for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jun 2023 06:56:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3925661769;
 Thu, 22 Jun 2023 06:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89652C433C8;
 Thu, 22 Jun 2023 06:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687416975;
 bh=BfwEl4KmCebHLldpn9d1Q3YO8cNoB5loaDHSdIqwyv8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ticyo0VJKdZ5pN216a1nzoGefcWrlqp6SGwJsZ9x/HaPUnTdpnfGZgUXEDeraCuoM
 1UODqOjTdhInxbqTGaiSOCfB/loxR1axP/7eLdQsD+2ZIaU6m2tYbPpvrmJqcfRWLy
 cFOUgAOz0acRk9n4f7BFsTNCaaZNwCuX2OVmVXRqSVFkbxYgipcpu7qoW3StS7+dB/
 8BpvaguW8LP/py/a7XIgBhMUPDqVm9viQKUrytCMIH4BUwHYH6oda62byzWpu3FU38
 c0A1tNpc8QlDtH/CUWjsiP3xZZqu3UCO1XqCeVaoy6WU6AhA4YHwSIRgZHEhjJCimG
 SnOIA9Vt3rSyA==
Date: Wed, 21 Jun 2023 23:56:14 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Message-ID: <ZJPwjvlz6Rwhc3ry@google.com>
References: <7cea747b-0255-669f-fdfa-932f275d09c7@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7cea747b-0255-669f-fdfa-932f275d09c7@bootlin.com>
X-Headers-End: 1qCEEv-00BFwK-JR
Subject: Re: [f2fs-dev] Trying to use compression options in f2fs
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

On 06/21, Michael Opdenacker via Linux-f2fs-devel wrote:
> Greetings,
> 
> I'm trying to compare the performance of the various compression options in
> f2fs versus the default settings, on an SD card.
> 
> Here's what I'm doing:
> 
>  * Creating the filesystem:
>    mkfs.f2fs -f -l data -O compression,extra_attr /dev/mmcblk0p3
>  * Mounting the filesystem:
>    mount -o compress_algorithm=zstd:22 /dev/mmcblk0p3 /mnt/data

This doesn't try to compress any file. Do we want to compress what files?
That can be specified by the extention name like:
# mount -o compress_extension=bar,compress_algorithm=zstd:22 ...

Or, you can set compression flag:
# touch foo.bar
# chattr +c foo.bar
# write() to foo.bar

You can check the number of compressed blocks by:
# f2fs_io get_cblocks foo.bar

If you want to reclaim the compressed blocks, you need to do:
# f2fs_io release_cblocks foo.bar

This will make the file as Read-Only which doesn't allow to update data in a
file. If you want to write a data, please do
# f2fs_io reserve_cblocks foo.bar

Thanks,

> 
> I'm running the tests on the Beaglebone Black board with a single-core 1GHz
> ARM CPU, using Linux 6.3.6. I'm using mkfs.f2fs 1.15.0 (2022-05-13), built
> by Buildroot.
> 
> However, I see no significant difference in terms of disk usage, read and
> write time, typically when I write and read an ARM root filesystem (from the
> Raspberry Pi Lite distro), compared to creating and mounting the filesystem
> with no special options. On Btrfs, the differences between compression
> options are really important.
> 
> I chose zstd:22 because I expected it to be the slowest choice in terms of
> compression. I'm expecting all files to be compressed (if they are
> compressible) by default.
> 
> Am I missing anything?
> 
> Thanks in advance,
> 
> Michael.
> 
> -- 
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
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
