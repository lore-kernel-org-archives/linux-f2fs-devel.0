Return-Path: <SRS0=uVaz=F2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E747DC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Dec 2020 08:36:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8358523124
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Dec 2020 08:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8358523124
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1krdA7-0008Ol-7A; Tue, 22 Dec 2020 08:36:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <gregkh@linuxfoundation.org>) id 1krdA6-0008Oa-I0
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Dec 2020 08:36:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n3ayuqputBV8F5p2JnPhFQsZtM3smnGE5TS7G43oRQM=; b=cfxowvAt3sO0Gncj6MgLBdX1rO
 v/1tfcF+VVk3PLjBrGYkKJOjipMCA6GFSpYz+q9keLE5PCpMmZZpHeQ7Fl1zRuECaEkasW8fkm7Rs
 ifK/+JQP2Io9mqBq0Mfzl8Zx9CbYqUvl49Rhejo7S9SNEa8L7vwhimfjciZO+1RWWg8M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n3ayuqputBV8F5p2JnPhFQsZtM3smnGE5TS7G43oRQM=; b=StwpAZYWwo++/B0x8Lu4CF3zW4
 /5OxiZqG/9TGJ4bG+cFIz+6JtC5nUcom14w+zNbn6EOSSYgNpU64T9HW07Hr80qmHNIfhTHYWPJPg
 AmpXonbP2eLWfA6XwuVdBgXnL6di6KzBJyRjXY6vOzuGPAw8n45StcSZOYX0TTvXJl0A=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1krd9w-005pFf-JD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Dec 2020 08:36:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 384A52311D;
 Tue, 22 Dec 2020 08:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1608626199;
 bh=48rJQnmzqEftD1VjzzcfOsmUsVzxjgaTphPkyo+ScK4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UCt/ESzr00Qj3/ivG8OTZmyqduOFyjavQMtaBNVP0PbrerWkBoYiEdmENUj8z3Ca7
 nPy251WplpYANInMY6PVt+rUsp9ZTttrI1D3GP04qXcNj/V3DfELeTjnnO4X1KDhio
 7q4LUba3FxgEPUHIBQadwXAgFm/S6xvK4Mxrn5NU=
Date: Tue, 22 Dec 2020 09:36:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <X+GwEz8NTepCKEFX@kroah.com>
References: <20201222011634.124180-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201222011634.124180-1-yuchao0@huawei.com>
X-Headers-End: 1krd9w-005pFf-JD
Subject: Re: [f2fs-dev] [PATCH 5.10.y] f2fs: fix to seek incorrect data
 offset in inline data file
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
Cc: jaegeuk@kernel.org, kitestramuort <kitestramuort@autistici.org>,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Dec 22, 2020 at 09:16:34AM +0800, Chao Yu wrote:
> As kitestramuort reported:
> 
> F2FS-fs (nvme0n1p4): access invalid blkaddr:1598541474
> [   25.725898] ------------[ cut here ]------------
> [   25.725903] WARNING: CPU: 6 PID: 2018 at f2fs_is_valid_blkaddr+0x23a/0x250
> [   25.725923] Call Trace:
> [   25.725927]  ? f2fs_llseek+0x204/0x620
> [   25.725929]  ? ovl_copy_up_data+0x14f/0x200
> [   25.725931]  ? ovl_copy_up_inode+0x174/0x1e0
> [   25.725933]  ? ovl_copy_up_one+0xa22/0xdf0
> [   25.725936]  ? ovl_copy_up_flags+0xa6/0xf0
> [   25.725938]  ? ovl_aio_cleanup_handler+0xd0/0xd0
> [   25.725939]  ? ovl_maybe_copy_up+0x86/0xa0
> [   25.725941]  ? ovl_open+0x22/0x80
> [   25.725943]  ? do_dentry_open+0x136/0x350
> [   25.725945]  ? path_openat+0xb7e/0xf40
> [   25.725947]  ? __check_sticky+0x40/0x40
> [   25.725948]  ? do_filp_open+0x70/0x100
> [   25.725950]  ? __check_sticky+0x40/0x40
> [   25.725951]  ? __check_sticky+0x40/0x40
> [   25.725953]  ? __x64_sys_openat+0x1db/0x2c0
> [   25.725955]  ? do_syscall_64+0x2d/0x40
> [   25.725957]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> llseek() reports invalid block address access, the root cause is if
> file has inline data, f2fs_seek_block() will access inline data regard
> as block address index in inode block, which should be wrong, fix it.
> 
> Fixes: 788e96d1d3994 ("f2fs: code cleanup by removing unnecessary check")
> Fixes: 267378d4de69 ("f2fs: introduce f2fs_seek_block to support SEEK_{DATA, HOLE} in llseek")
> Cc: stable <stable@vger.kernel.org> # 3.16+
> Reported-by: kitestramuort <kitestramuort@autistici.org>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
> This will cause boot failure in f2fs image, which was reported in gentoo
> community, I'd like to fix them in stable kernel 5.10 first as request in
> bugzilla:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=210825

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
