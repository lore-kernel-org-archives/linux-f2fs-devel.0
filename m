Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27149C4452B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yRu02qpnMQJ4n69bEKIhIMScmM9WQNhzeXBo/rANrgc=; b=l+JXBCTkxoDWTg45F/DNAbthEe
	+G5Fs0iR2QqAC00B24quWICMK2/kvobNpNAUpR0DdC4ebqpv5B/Xl3xSwMewh8M1CI1tBP1V4uH9i
	Ic8Kd8DHdx3JLW0GdoBjmdj+/tplpdbZL1GMkjWzVRZgDYAaPLxL/OESoEjsNQS+lcZw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmLfV-0005En-Nj;
	Wed, 22 Jul 2026 01:22:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wmLfU-0005Ca-VL
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 01:22:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/mdT7jkMjc7sjvrquAnjFRY5QkVWbjefxRKNNQNYOUc=; b=UiCl9iL0lYVgEmEytJ7iJfHqfZ
 0+LDw7dd65TNsJ+M4U/zbuHOsm0O1C/3Pu4txL+3czIEG8HJAyXsGZMXkiXrhtgx5it68mKrjJMch
 1WDdmf1zfp2/Nf8DJH1wt5WYp2KGioD3S0z0e0X2dMfiWzvIsV+2GMREy2BWx5VmxNGU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/mdT7jkMjc7sjvrquAnjFRY5QkVWbjefxRKNNQNYOUc=; b=ACfTBCKOTMy788crNXUkMhojC1
 LlUfx2+tBA9Q/8yxiFO7q9vOlo+HinI6OahZ0SzNi4143t0djn6V+zI5JHfGArjEbKuXMG1v8/JZz
 MLMpV9r5pnKy+1S1gBBZgoo6NbPdJKGtlBOV6M7CS7bGi52GehUwIqLkIN2r/ZKTdGJo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmLfV-000184-4O for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 01:22:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D817601EC;
 Wed, 22 Jul 2026 01:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258531F000E9;
 Wed, 22 Jul 2026 01:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784683349;
 bh=/mdT7jkMjc7sjvrquAnjFRY5QkVWbjefxRKNNQNYOUc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=GMVRgGEq0Ekm/HdYqrmx+Jd1ZvgwMvLyNrZUrhg31y4yrN6SqkrQz6bc3Z+b1Tfnw
 mPdu4tEQ0m//1DN5Svt4iar52Lx3SAIwsRbuGSZfoekShzKy5hbk5wwF/LhPcjR2Qz
 M/wD6s3PkmYBoKcNU58zTNt1H2kK3Z5jIz7jtgi0rxxdVpwBcjegWhVJyq/+FywIpv
 ty8YcL2fVrgIc9by7g3lATAiZluiFM5OGByz77eTAbqVdQwhuoeygVy9ngOzIRg7pR
 zBNfVdnk8ClWKMfjBX4n7JQSzQgkhA5COJ5e3sPUiHMi6YOx73odJUnGH2QCZEM1ji
 jsdBhtIjAZlAw==
Message-ID: <d3500e74-6e7f-4535-baba-36c63f0601c8@kernel.org>
Date: Wed, 22 Jul 2026 09:22:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@kernel.org>
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org> <akKd2IImO7bRjVV2@zlang-mailbox>
 <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
 <alyS3PRtALHIV5no@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <alyS3PRtALHIV5no@zlang-mailbox>
X-Headers-End: 1wmLfV-000184-4O
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
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
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, jaegeuk@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Zorro,

On 7/19/2026 5:24 PM, Zorro Lang wrote:
> On Tue, Jun 30, 2026 at 08:09:19PM +0800, Chao Yu wrote:
>> On 6/30/26 00:37, Zorro Lang via Linux-f2fs-devel wrote:
>>> On Wed, Jun 24, 2026 at 12:46:01AM -0700, Christoph Hellwig wrote:
>>>> This sounds odd.  The test allocates a contigous range and then just does
>>>> insert/collapse on it, which should not lead to any new data block
>>>> allocations.  Given that the test works fine on zoned XFS and btrfs
>>>> with strict out of place write policies we know it does not require
>>>> overwriting blocks to work as well.
>>>>
>>>> So I think something is fishy in f2fs if needs to allocate data blocks
>>>> here.
>>>
>>> I have the same question with Christoph. Shouldn't fcollapse in F2FS just
>>> remap the metadata instead of allocating new data blocks?
>>
>> Hi Christoph, Zorro,
>>
>> Let me explain it briefly, this is because f2fs has only one copy of reverse
>> mapping table (aka SSA), for any checkpointed data, we can not modify SSA info
>> directly during remap, otherwise, after sudden power-cut, we will suffer
>> inconsistent issue in between reverse mapping table and mapping table. So, f2fs
>> choose to rewrite for any checkpointed data.
> 
> Hi Chao,
> 
> Thank you for the detailed explanation. I now see why F2FS handles this
> differently.
> 
> Since this is by design for F2FS, I'd like to merge this fix to help f2fs
> avoid this test failure at first. As for the potential write amplification
> and performance overhead introduced by this rewrite strategy, that can be
> discussed further on the f2fs list if necessary.

It makes sense to me, we can discuss about the detailed implementation in f2fs
list if there is any concern.

> 
> I will merge the patch with some clarifying comments:
> 
> /*
>   * F2FS uses a rewrite strategy for fcollapse/finsert on checkpointed data.
>   * Since F2FS has only a single copy of the reverse mapping table (SSA),
>   * directly remapping checkpointed metadata could cause inconsistency
>   * issues after a sudden power-cut.
>   */
> 
> Is this ^^ good to you, or feel free to give me a proper comment to add into
> this patch.

Looks good, thanks for the help!

Thanks

> 
> Thanks,
> Zorro
> 
>>
>> Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
