Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E53CC6B03
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u/O6V5JJhq5pl7E/HBv3mndupdBtpJ5bWIrDdoIrIMY=; b=EfH6hrMI8VdJe0gNkwBR6lJaHF
	aB8ENnFOKlc68cWZjpoA5YpICcSdRl21oRJnR/KY1WiuoXckqWOSYbbUChFiSb3hopBB3DrSsPm8l
	+8Qg0PwWw05GnISz15HQ5G2t1rzNsBPe81glvj+ewMswgFXcsQ8nV+CtbjEwAtIzHHRg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGavJ-0001uu-Du;
	Tue, 13 Oct 2026 11:44:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGavH-0001ul-PC
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:43:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WYqP17YR8Fnv2z690xmACFHdaqhjm09/Y/uZ/X3/pZc=; b=AKPdwJbeMhXNuBODTrO56TLpd9
 efhfBq4BtXwX7EoI+kB3B8nJrRB3diRwJwBC3898xkaUcsclhxAlV65sfAF2qe8yTXB8eE+ACfdN8
 wNp6Kr4NMq4Z7rLNck7QMmBKH5YDCSUGpnLZsD1257YNalPZB5rj13USh/MPGlms/59M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WYqP17YR8Fnv2z690xmACFHdaqhjm09/Y/uZ/X3/pZc=; b=VEHkkD1SHihAf6BSD/4dEgfKjA
 /pPT9rMcFV19nbHSe8JcWqHkWu6hApsgno+UaHkU5uUdUjgrPd/4cLtKZGZUS9bzchnZNNngUDydo
 nojhKPkd4X3BrQHPTYBjuC9Z2p8If7Rfu7vO/lrz4sN/Sqo6ehq+JuFZlL3wjBq5ahdU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGavG-00013X-9Q for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:43:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 012244389A;
 Tue, 13 Oct 2026 11:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CDD1F00893;
 Tue, 13 Oct 2026 11:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791891832;
 bh=WYqP17YR8Fnv2z690xmACFHdaqhjm09/Y/uZ/X3/pZc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Pz/4qzLr47zKazdpyX/o7xuvU7HgouSJ3+E1/HkpjyGc0QwVUgU81QDIrM6kRoyQU
 jKVKTvgdNBU9syYmaSGbHPWB8GLf1go4sf5+oUkvdZU94fB/HMbch7kKUVXjE9c3Rx
 1awkIstap36u4wVYfHzyewkhzZR7gMRCpusNTIgVM/6I9Rli/iR9OT5oGoVBzJBJoY
 rJcGojwAtCGSXfFAeJyZ8qy/Hg+icOOT9Xnzoer6W9zA+J/b0GeepiQZxy/2EFomda
 aocvKVZeJEX+K5PXDbRH/08ewerEQdabFaFYgiQvIBRJajNKcoL9Vhva4F+PJISf7G
 JMMDljCknwpCA==
Message-ID: <ff9241ab-c017-4b15-a0c4-4d5b660130ba@kernel.org>
Date: Tue, 13 Oct 2026 19:43:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Daeho Jeong <daehojeong@google.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261013105628.869156-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261013105628.869156-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xGavG-00013X-9Q
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: read i_size once in
 f2fs_vm_page_mkwrite
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
Cc: Barry Song <baohua@kernel.org>, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/13/26 18:56, Nanzhe Zhao wrote:
> f2fs_vm_page_mkwrite() reads i_size twice: once to check whether the
> folio is partially beyond EOF, and once to calculate the offset for
> folio_zero_segment(). But a concurrent buffered write can extend isize
> and cause the following race condition to corrupt data:
> 
> buffered write writes [0,3500)
> 
> CPU0 (write fault)                        CPU1 (buffered write)
>  ----                                     ----
>  f2fs_vm_page_mkwrite()
>  folio_lock(folio)
>  if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
>  i_size_read(inode))
>  /* i_size_read() = 3500 */
>                                            write(fd, buf, 200, 4096)
>                                            /* writes into page1, does not
>                                               wait for folio lock */
>                                            i_size_write(inode, 4296)
>  offset = i_size_read(inode) & ~PAGE_MASK
>  /* i_size_read() = 4296, offset = 200 */
>  folio_zero_segment(folio, offset, folio_size(folio))
>  /* valid data [200, 3500) is zeroed */
> 
> Fix this by reading i_size once and using the same value for both the
> EOF check and the zeroing offset.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261012030315.978375-1-zhaonanzhe%40xiaomi.com
> Fixes: fbfa2cc58d53 ("f2fs: add file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
