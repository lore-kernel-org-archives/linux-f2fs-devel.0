Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED694CDB47F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 08:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZPpYlkOtrFZ4JCnL+AW5Qsn0G0g6CGZVkfpKzrdUl1M=; b=QrwznR3aagyC1I4bz+H76nP2w6
	E2P2RWl1M/XEkhil6bwbiobyCHfw/EPKG5BAfpDUOsmX4Mrg5YUnnMKn+QySwf22bfjS9k/5x3x2k
	1FotZqQHLz0LKXVDrpQbLJZ7vD9w3UOC66wWVDen1VWT4lXuaEJ1NK35bbHsnr0sJpfY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcIyZ-0007pi-KO;
	Wed, 24 Jun 2026 08:28:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wcIyT-0007n9-2s
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 08:28:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wfh/P99IwchT4VHP5S2uoDUD6OJUbSYALHpjt96hxt8=; b=fhN6Iy2wI7munOajXvvuM+/cLK
 LbdiCgJ/of2+m59RWs3d8Hh0GeYSmm1pYKJoQwhnVmvWdDSZSHCcUwDZMm84RDqORH3KsD9uKiDzC
 3tbIZfeRS0yXZuhYHZRd6Lwn7FZVPlT5lXB8x3vqninu76kJKeUM0ymEaHjx0NtBZhQU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Wfh/P99IwchT4VHP5S2uoDUD6OJUbSYALHpjt96hxt8=; b=BrwVxBkUBBu6xe+nnyj10fBq9f
 HnR2h45i5uh7zXja1d/dfzWmwaNoZKfceV8aBFbu+ltDU3uCQSPF4Suib7gPxs1fjT2Dj9J2/CJs8
 sHM5kCgk4jLSoC8CLg3SIT0ha9MKW2nq8On0I0qLpV4DQcau7eGMycRYjrB8nmXEINZQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcIyO-0005r4-1I for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 08:28:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24730402F9;
 Wed, 24 Jun 2026 08:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6E71F000E9;
 Wed, 24 Jun 2026 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782289710;
 bh=Wfh/P99IwchT4VHP5S2uoDUD6OJUbSYALHpjt96hxt8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=nbjVXSoh8lGDMcEIFETBOWr5/TbVI4Pz/S7rlr+ncCl83wfEgJHEb7rLLiajGp/E3
 +yHKC/8QmnNc2OAVgoUzViGGC0hCoFKu6+4k/WTGpAhZqiobITU5USuzX1Q9+9DpsU
 85I+VhDlDkE+l4R+pU1fRN+oDhLs1y3Bb+Nb5uHFxzVRq+AR7qPv6qKr0Fk5zl/mJt
 OP30YI7TfSb3Zk6aKMKKeXMfsRYynv8QyFwclKvvtS2CnByblgsuB5o+pFzppXrZTZ
 pA7UydHKJrEdOqukbouVQwh0FPC/iiNRMejeDZKRJxS7TbZ5AZs3ga7zRGhV6pSRJc
 RLeut/SZoFwxA==
Message-ID: <d25d1fb2-de6d-4a92-a798-fd304e8e5654@kernel.org>
Date: Wed, 24 Jun 2026 16:28:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Biggers <ebiggers@kernel.org>
References: <20260622011539.2292553-1-chao@kernel.org>
 <20260623232926.GA7864@quark>
Content-Language: en-US
In-Reply-To: <20260623232926.GA7864@quark>
X-Headers-End: 1wcIyO-0005r4-1I
Subject: Re: [f2fs-dev] [PATCH] fscrypt,
 f2fs: introduce fscrypt_finalize_bounce_folio() for cleanup
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
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/24/26 07:29, Eric Biggers wrote:
> On Mon, Jun 22, 2026 at 01:15:39AM +0000, Chao Yu wrote:
>> As part of the linux kernel's migration to folio-based APIs, introduce
>> fscrypt_finalize_bounce_folio() as the folio equivalent of
>> fscrypt_finalize_bounce_page(), and clean up f2fs codes with this new
>> helper.
>>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Cc: Eric Biggers <ebiggers@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>
>> Is it worth to introduce fscrypt_finalize_bounce_folio(), then try to
>> do clean in f2fs_write_end_bio() first, and then replace
>> fscrypt_finalize_bounce_page() later?
> 
> I'm working on making ext4 and f2fs always do file contents
> en/decryption using fscrypt_set_bio_crypt_ctx(), which already supports
> large folios and doesn't require the filesystem to manage bounce
> buffers.  I don't think these minor tweaks to the other implementation
> (which don't actually make it support large folios) accomplish anything
> useful, and we should focus on removing it instead.

Good, I see your patchset removing those codes, let's ignore current patch.

Thanks,

> 
> - Eric



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
