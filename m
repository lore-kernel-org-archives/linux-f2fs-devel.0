Return-Path: <SRS0=MwkT=MZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B015FC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Aug 2021 09:00:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7999E60F9F;
	Mon,  2 Aug 2021 09:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7999E60F9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mAToM-0003CC-VQ; Mon, 02 Aug 2021 09:00:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mAToL-0003BP-6j
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Aug 2021 09:00:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J3FBLLb4BbWbdc2wnMLOgBCam6BTXPUvTyz8DrBg4Uo=; b=Jpm5LMop0bmZP+QkHEFfe0G3Q/
 R39tsCk491Y2HF+ONB3QP4JDzOkOejbgaJ9vDoOOowABFJeRyCodCKoH6dSa0lrU7X93XPYrqv5vc
 AfJsxN2YPmzXnT1YHEQXHWlu78UgvaQ/bCJxMnQWclK6DonJZ/FyzHm42Zxhp7kg6kbg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=J3FBLLb4BbWbdc2wnMLOgBCam6BTXPUvTyz8DrBg4Uo=; b=fv1gr/E76aW4Jl6wRDKsTFVp+e
 ylaivPPdl+6z9OlJuL8ETdahfIeg0AFizyVVosscU+OGIKAR1R/LuYXW8ooYqpEuom0aI6k8qYs/8
 ElZ+KJ59uo85/pxvmJDgW0Iy0jQlxjEtX5Wmz/9+VL0yBSbznGAI1Pz0clB+Vtf+rFGg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mAToC-0003ag-JW
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Aug 2021 09:00:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6832860EBD;
 Mon,  2 Aug 2021 09:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627894817;
 bh=NpGYxMxPtr0QSqg+p3P23qf5aNI0HOKU5NMbrglC06Y=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RdoQGF598VsHZscJC5HMR3we486QnR63NlWZ5ruA3kXqcyZu1Xq5eGtri+xlTiPFZ
 z+Pzx3D4O+YR5+qVkKcRl9Lp7NtBn4jBuNi2KOmY5qq3fzArDmV432u2NUXjwtpPDB
 vX/7/MQbJnNmRXLtumUOdf5EHFZHfKUr96PqD1Yn5PclZQvXQYNketFumi4dcgsI0k
 X7RImEgtiF1tVMlS0ImsrsZ37cnFyq/Aoh533Cjzq/3VH2BABrTQAe4ZoQeEke4/rW
 I6YZb1I5/DL/NEarggj7M4msoiSivQpXYNOVBih4zMEloTJF2bhwC2SSRvDJA9srnB
 q8sIRtOirdNMw==
To: Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>
References: <20210728015154.171507-1-ebiggers@kernel.org>
 <YQRQRh1zUHSIzcC/@gmail.com> <YQS5eBljtztWwOFE@mit.edu>
 <YQd3Hbid/mFm0o24@sol.localdomain>
From: Chao Yu <chao@kernel.org>
Message-ID: <a3cdd7cb-50a7-1b37-fe58-dced586712a2@kernel.org>
Date: Mon, 2 Aug 2021 17:00:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQd3Hbid/mFm0o24@sol.localdomain>
Content-Language: en-US
X-Headers-End: 1mAToC-0003ag-JW
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove broken support for allocating
 DIO writes
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
Cc: linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/2 12:39, Eric Biggers wrote:
> On Fri, Jul 30, 2021 at 10:46:16PM -0400, Theodore Ts'o wrote:
>> On Fri, Jul 30, 2021 at 12:17:26PM -0700, Eric Biggers wrote:
>>>> Currently, non-overwrite DIO writes are fundamentally unsafe on f2fs as
>>>> they require preallocating blocks, but f2fs doesn't support unwritten
>>>> blocks and therefore has to preallocate the blocks as regular blocks.
>>>> f2fs has no way to reliably roll back such preallocations, so as a
>>>> result, f2fs will leak uninitialized blocks to users if a DIO write
>>>> doesn't fully complete.
>>
>> There's another way of solving this problem which doesn't require
>> supporting unwritten blocks.  What a file system *could* do is to
>> allocate the blocks, but *not* update the on-disk data structures ---
>> so the allocation happens in memory only, so you know that the
>> physical blocks won't get used for another files, and then issue the
>> data block writes.  On the block I/O completion, trigger a workqueue
>> function which updates the on-disk metadata to assign physical blocks
>> to the inode.
>>
>> That way if you crash before the data I/O has a chance to complete,
>> the on-disk logical block -> physical block map hasn't been updated
>> yet, and so you don't need to worry about leaking uninitialized blocks.

Thanks for your suggestion, I think it makes sense.

>>
>> Cheers,
>>
>> 					- Ted
> 
> Jaegeuk and Chao, any idea how feasible it would be for f2fs to do this?

Firstly, let's notice that below metadata will be touched during DIO
preallocation flow:
- log header
- sit bitmap/count
- free seg/sec bitmap/count
- dirty seg/sec bitmap/count

And there is one case we need to concern about is: checkpoint() can be
triggered randomly in between dio_preallocate() and dio_end_io(), we should
not persist any DIO preallocation related metadata during checkpoint(),
otherwise, sudden power-cut after the checkpoint will corrupt filesytem.

So it needs to well separate two kinds of metadata update:
a) belong to dio preallocation
b) the left one

After that, it will simply checkpoint() flow to just flush metadata b), for
other flow, like GC, data/node allocation, it needs to query/update metadata
after we combine metadata a) and b).

In addition, there is an existing in-memory log header framework in f2fs,
based on this fwk, it's very easy for us to add a new in-memory log header
for DIO preallocation.

So it seems feasible for me until now...

Jaegeuk, any other concerns about the implementation details?

Thanks,

> 
> - Eric
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
