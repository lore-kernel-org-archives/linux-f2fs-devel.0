Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B952960A2618
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ir+1rkTE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BY0jEiEg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IRAobJo8;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iv03Gpb+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=d2hlaowV/AlSEdniH39O28Nj/h3xHsjG3zBju2Desgg=; b=Ir+1rkTEuX2f0E
	GpX27aEWfHaRVDrKWGTovhXlAMGbKAPnVIGfTPLNR7W5XtWgFYlPKYCwa0zTMVz1seaqNqpktlp0M
	dg+7EnHWFZlu+9JGg5ZLKmSWF0DbZvcy4jmM389FGVQPkpcwt5OrGqzapsOgCwOoisJ9j73+k01kJ
	cXc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xR4GG-000000004eM-23l2;
	Wed, 11 Nov 2026 09:04:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xR4GE-000000004eD-3bzI
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:04:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tw4MBR2nQ4JcguOEhZ8yHA2Hq3NkQmlLl/rKAtx4S0s=; b=BY0jEiEgx5znHfXfhEaPsZD6M5
 DtUaEYGgvnoArUp9ge5h/V5mpzvScBVBe50uwXRiLh39f95oOmqPZ9nP6HDhheX+WHGxI2VE3wVJO
 mSpgMVdWaNxYo6sz/juF2S4nm5WZyhHiObKzLbV5G3Fs5M6J7HJkSevCaUYnxqpqw8Kk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tw4MBR2nQ4JcguOEhZ8yHA2Hq3NkQmlLl/rKAtx4S0s=; b=IRAobJo8ib50EYuwjEa9spraTp
 GJXgP2A+nxnUJROnF6eF2uROp8xZg1RkhXh+t4NK9rvcIV/dQDAvQjpobbStxcsB8bqpMONo/FlKY
 4kpgg++9UeOCspbAjXkzxJzZDtiRN3/uEV/EuBiIvFVf0otAG99I/sLOuF0GKj1RZOsA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xR4G2-000000001Ce-1bW2
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:04:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BF88163BCC;
 Wed, 11 Nov 2026 09:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9A01F00A05;
 Wed, 11 Nov 2026 09:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794387876;
 bh=tw4MBR2nQ4JcguOEhZ8yHA2Hq3NkQmlLl/rKAtx4S0s=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=iv03Gpb+7C2wrp/t27Vm3RLLSiGGsDKF3a4nqKWoODyAXYYjUodMgi7sdJ+XnKg2y
 ho69VqOHH+V1GoJro9Zng3pMAIopvTLx0Ex3O8csRNN6JnLgL274bpa5KiGZy+TKfy
 N3OEx+tntYllVgL31SjxZSdxJe41wllqq10PV/kgOfENQBVgBEVOR9nbx0BJLEF5NX
 VRu0Co3S/W7f4hI9jESyiFvFIVzDdiRSqgkk/YjvgjWaJVqOe8cfUlWze2qkhL7DNT
 XFUI7TNkttPp+A9w3ntbAuj7oNbN2OeZtBK2vO6feDnX9zJTWIscY8x9xxkaBnXUkU
 HUYMBRc1HM6KQ==
Message-ID: <102da404-ab62-4ba6-b46a-1846ca64c72b@kernel.org>
Date: Wed, 11 Nov 2026 17:04:33 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seongjae Jeong <jsjlee1020@gmail.com>
References: <20261004061007.7433-1-jsjlee1020@gmail.com>
 <f3f5fe2c-f0f5-4c23-a2f7-6cb5e09ced5a@kernel.org>
 <CAPHXVrzaWHYccYe+PWLeAf_N3md8ens0UsW7aH-047KGhM4BUg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPHXVrzaWHYccYe+PWLeAf_N3md8ens0UsW7aH-047KGhM4BUg@mail.gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR4G2-000000001Ce-1bW2
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip further SIT updates for already
 invalidated blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, yi.sun@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/26 18:39, Seongjae Jeong wrote:
> Hi Chao,
> 
>> Cc stable.
>>
>>> Fixes: 81ffbd224e5f ("f2fs: update_sit_entry_for_release() supports consecutive blocks.")

Hi Seongjae,

Oh, sorry, it seems original Fixes line is correct, my bad.

81ffbd224e5f ("f2fs: update_sit_entry_for_release() supports consecutive blocks."):

-       if (unlikely(!exist)) {
-               f2fs_err(sbi, "Bitmap was wrongly cleared, blk:%u", blkaddr);
-               f2fs_bug_on(sbi, 1);
-               se->valid_blocks++;
-               del = 0;


+               if (unlikely(!exist)) {
+                       f2fs_err(sbi, "Bitmap was wrongly cleared, blk:%u", blkaddr + i);
+                       f2fs_bug_on(sbi, 1);
+                       se->valid_blocks++;
+                       del += 1;

The patch changed from "del = 0" to "del += 1" incorrectly.

-       if (!f2fs_test_bit(offset, se->ckpt_valid_map))
-               se->ckpt_valid_blocks += del;
+               if (!f2fs_test_bit(offset + i, se->ckpt_valid_map))
+                       se->ckpt_valid_blocks -= 1;
+       }

And from "se->ckpt_valid_blocks += del" to "se->ckpt_valid_blocks -= 1".

Let me know if I missed anything. :)

Thanks,

>>
>> This commit didn't change previous logic? IIUC.
> 
> The discard bitmap handling already existed before this commit. It was
> introduced
> by a66cdd985532 ("f2fs: introduce discard_map for f2fs_trim_fs").
> 
> However, 81ffbd224e5f did change the checkpoint accounting.
> Previously, del was set to 0 when the cur_valid_map bit was already cleared,
> so se->ckpt_valid_blocks += del left the counter unchanged.
> That commit replaced this logic with se->ckpt_valid_blocks -= 1,
> regardless of the del value.
> Thus, the counter is incorrectly decremented.
> 
> Would it make sense to add a second Fixes tag for a66cdd985532 to cover
> the discard bitmap handling?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
