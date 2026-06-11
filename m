Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F414DCD98C7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9RTEyq7rWFCV37JXZDh4IYF7YB+2jhWYJ5QcUw17HeY=; b=R4JHrCRXTwKSwgJJ3E7kQiRIQj
	FgV/I7n4RgkBsZoo4wsRaLLrDkkPD0IFlruBWnXgnt2B31cS/Vxl72X1w2SLzKw+duFg7SAYVwfxI
	iXnGkk2qNeeGi5u1rgrzegruAJeUWTDSbvASsHdEzQpqNux5QOYgOLmcIepP/XkwbMmE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXaWv-0005P8-9I;
	Thu, 11 Jun 2026 08:12:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wXaWt-0005P0-DV
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 11 Jun 2026 08:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j/xYYVnQQ/67Yg5UycSzop9Vdemv8h8Ilxc2ghpNZb4=; b=cW6LtUzhdFQdnXv0hsOrTqTPei
 ZhJpalcdNdQ2E/R1hhnfIpckMwV/kWZGVSww7kREkiTuLzxK9t9gdyOJg8NDyzMaKhm6X4s/Z8uce
 gsQD2Tdo8SZKj/5swX6N1ISQ3GZcsay3pvUi6+HUbsKienTXbqvBZeLAMPVjooPweUKU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j/xYYVnQQ/67Yg5UycSzop9Vdemv8h8Ilxc2ghpNZb4=; b=P4hDW4JltpfwNKk7zsZrvZHN4x
 sABU8QLmtQbKPmDAOdBTlUrYEDhs11sx62YMYCfC67Qo8ak1hUuxYLTCafOYb7QWIO79YwKhrORIx
 BHMZYWkztHmGgv6h4o4bYb/qMBs6pvuDiv9bXFFgkZ939HZ0tRW9heRJ3Lfme4QcVHIE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXaWr-0004tm-6E for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 11 Jun 2026 08:12:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06F3060052;
 Thu, 11 Jun 2026 08:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085DF1F00893;
 Thu, 11 Jun 2026 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781165554;
 bh=j/xYYVnQQ/67Yg5UycSzop9Vdemv8h8Ilxc2ghpNZb4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=MIsJgg+O7OZoOnNpFY/TXQ8OeSI6/TJFtMFDF8uOnHjU1HGn5eHlqo0AeXcAytThL
 myYm5tCcBUNqKFh9uE0Op5h2modnZRUmZ31vkWBuUXUbdlN7LfBnCrtCrFJTOk/ovY
 i+OFMfBPBKbjcxlwl825NPfsZr2CdXPbDOvECGBgbxJHI6TWsp4q7xaVv67ta8APDZ
 nx1sPVA4HI/BaOIrBrfIcZlZfLkddeSxA+/vQXrQpx5y0xjbspa+6vAp1WLvk/IZYL
 MfeoKTndLkVQi5mcj4fv+jorZx4XGomQ+VgKQOsKiUyChB92SGhazQl1pH+ybj+icE
 OQq0vQ/ElXCew==
Message-ID: <42d9f2ed-2402-46dd-a8d5-37dca2adfb29@kernel.org>
Date: Thu, 11 Jun 2026 16:12:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260527120628.2255597-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260527120628.2255597-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wXaWr-0004tm-6E
Subject: Re: [f2fs-dev] [PATCH] f2fs: keep atomic write retry from zeroing
 original data
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/27/26 20:06, Wenjie Qi wrote:
> A partial atomic write reserves a block in the COW inode before reading the
> original data page for the untouched bytes in that page.
> 
> If that read fails, write_begin returns an error but leaves the COW inode
> entry as NEW_ADDR. A retry of the same partial write then finds the COW
> entry, treats it as existing COW data, and f2fs_write_begin() zeroes the
> whole folio because blkaddr is NEW_ADDR.
> 
> If the retry is committed, the bytes outside the retried write range are
> committed as zeroes instead of preserving the original file contents.
> 
> Only use the COW inode as the read source when it already has a real data
> block. If the COW entry is still NEW_ADDR, treat it as a reservation to
> reuse: keep reading the old data from the original inode and avoid
> reserving or accounting the same atomic block again.
> 

Cc: stable@kernel.org

> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
