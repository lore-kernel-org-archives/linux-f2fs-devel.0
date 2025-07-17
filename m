Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F3BC83F34
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQOn/KdxEuRtHlZ5gnBR8PZzaQBcD5thgrKSgAwjWJE=; b=M5JHd/4nvFF6HlBuVba+aOE1MN
	KAov8ZzNDyHhKgBewmFlCfEujmk8uXVwVfQSBRFx+2v2EmgRlBBYX9T0sfDQZX8/c/7wVr3I+jg4C
	8+cMSiFKXKVDzBoNpe0VAdnYRs2ew2yKo1qzVTba2NHQG6QFgtgo7hCh9Kog1dEIrnng=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ucF8m-00042o-0R;
	Thu, 17 Jul 2025 03:18:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hsiangkao@linux.alibaba.com>) id 1ucF8j-00042T-P4
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Jul 2025 03:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4gUaF7R4/EBDJfRjJRTdp0icwbrWb7f2nyKt3jMgey4=; b=lF+07i8khTXLWpcpSDbCMnN0CF
 nQbzhYPvY3Z8EKh1SgCxL5kA4tgeCOMpAcGqbskhLu8X/yXQPmNGW5OeCP/ooqNelk2rPaGsJ9ds/
 GDlY6igQVmc2qDQpgTSZadeyKQO6lowxaiITqQE9k9QpPNJKCpUr3FwF9zaTRQK/DI0U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4gUaF7R4/EBDJfRjJRTdp0icwbrWb7f2nyKt3jMgey4=; b=DmQu/gS0sCgqAZTgWspJCFJ774
 WWc1TIoEAdf7mkXUDU/9nfxKvxPsG4WuZS8OiRQmD0z+ZflBx3gERp7FgFWIzfEvwxyM6BD/rpNbb
 afhGk3KqDdb7LrnraXY47Ttzv16G8CxXMq0ywOHRla0CFXzFhUhruXjxQDF6e9EiDCFY=;
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ucF8j-0000UW-Tb for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Jul 2025 03:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1752722301; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=4gUaF7R4/EBDJfRjJRTdp0icwbrWb7f2nyKt3jMgey4=;
 b=N2KlNCfULoPaHg2HsLHiXH7o7NBbs4UlhRpN5jU97WfU57/CWeL8g+QEBMDJD7adoqakPuz1cBfa4p7QU6tcTL1yTRAFWuPVhM2kuo0nuShAxq1K5X3cEkkl710FHkmlb9m8rUTwIDz+mM1gwaPO05l7ca4i/xvFRST4A58qZl8=
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Wj6YBs9_1752722299 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 17 Jul 2025 11:18:20 +0800
Message-ID: <51c92913-6176-4516-8b14-bd12e2a85697@linux.alibaba.com>
Date: Thu, 17 Jul 2025 11:18:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Biggers <ebiggers@kernel.org>,
 Phillip Lougher <phillip@squashfs.org.uk>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <f4b9faf9-8efd-4396-b080-e712025825ab@squashfs.org.uk>
 <20250717024903.GA1288@sol>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250717024903.GA1288@sol>
X-Headers-End: 1ucF8j-0000UW-Tb
Subject: Re: [f2fs-dev] Compressed files & the page cache
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
Cc: Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Chris Mason <clm@fb.com>, linux-mtd@lists.infradead.org,
 linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Matthew Wilcox <willy@infradead.org>, Gao Xiang <xiang@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Howells <dhowells@redhat.com>,
 Nicolas Pitre <nico@fluxnic.net>, David Woodhouse <dwmw2@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 2025/7/17 10:49, Eric Biggers wrote:
> On Wed, Jul 16, 2025 at 11:37:28PM +0100, Phillip Lougher wrote:

...

> buffer.  I suspect that vmap() (or vm_map_ram() which is what f2fs uses)
> is actually more efficient than these streaming APIs, since it avoids
> the internal copy.  But it would need to be measured.

Of course vm_map_ram() (that is what erofs relies on first for
decompression in tree since 2018, then the f2fs one) will be
efficient for decompression and avoid polluting unnecessary
caching (considering typical PIPT or VIPT.)

Especially for large compressed extents such as 1MiB, another
memcpy() will cause much extra overhead over lz4.

But as for gzip, xz and zstd, they just implement internal lz77
dictionaries then memcpy for streaming APIs.  Since those
algorithms are relatively slow (for example Zstd still relies
on Huffman and FSE), I don't think it causes much difference
to avoid memcpy() in the whole I/O path (because Huffman tree
and FSE table are already slow), but lz4 matters.

Thanks,
Gao Xiang


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
