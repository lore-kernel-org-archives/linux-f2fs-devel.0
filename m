Return-Path: <SRS0=/3/5=6F=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB91C2BA19
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:31:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B2E2073A;
	Tue, 21 Apr 2020 07:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="j+ljbL6m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="SUL6QaeT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="H5J0hhVK";
	dkim=neutral (0-bit key) header.d=aol.com header.i=@aol.com header.b="KpaZLk24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B2E2073A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ryZcWEudIzBBQVi5t0QX+2ov5sIdnQ8UfFTdG0v8sM8=; b=j+ljbL6m47xkMHbuxLkfPlQEw
	cAQRYbtQX3rIfHzmuDIz9+JBJcyWb7yjfAQmR0BRnEn/mXZOM8tbVhoQWdaeP8lAhFvJY4Ek+D2qj
	H/NZAQ9Ffd5XgPgcg40qYgQRx6MbRUWhHFF1ozy7MhwVRWlpUbNbvkEAENyTHfSRPHJDU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jQnN8-0002PZ-Eh; Tue, 21 Apr 2020 07:31:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hsiangkao@aol.com>) id 1jQnN7-0002PI-AC
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Apr 2020 07:31:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8SaBe657SUqzMIHOQXCqE8E7juFfQ/VceplMPZo+D8w=; b=SUL6QaeT4Vg5d1aohyZzuQa4E7
 3x1mxezqBMjEVmxHE8gxtf6FVXXSiGl3Q46gVj4SU3Zp+kyL+1LGULJiccpEMWTTG6ovktdDkMs5z
 nXZ/bA0OEjfLfVg3b2Rg8iePn5EFF1Jh9NYZyrY6uyK1JEHREgNWdIJCZXm9krVck/j8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8SaBe657SUqzMIHOQXCqE8E7juFfQ/VceplMPZo+D8w=; b=H5J0hhVKtb2ImXY6mF2M1g8tP7
 Nebphieq6+QhEXnKhTOAzwgGccVS4P/Y3A/XjqwUy2h2AF8VnzlCzmrfBADiWoK9/pcVAj4S+eYgQ
 V+H1ccwfT44/tuswR5JxnEz3KJ5JxbsJcV/vTj2Iu+8TjUJ9ZzjlPF1nGPSU854y8hKs=;
Received: from sonic309-49.consmr.mail.ne1.yahoo.com ([66.163.184.175])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jQnN5-008nxR-8X
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Apr 2020 07:31:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1587454261; bh=8SaBe657SUqzMIHOQXCqE8E7juFfQ/VceplMPZo+D8w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=KpaZLk24UVqPwIBYC2dgf14lue+EQnfVzZFTJmxMC6TsT7WKiMhtq08Fetju5nTIV7GNbh+7nSybfvPnBgN8i47khQXY2HmIZwMOVXi4SCV3ErhFWLgDWLc2qBmEGV/6gKpYAGFLOSpKngk5Fx2V55XG7FOC/CX3KhYAWpkwIEl+fBOolBaLqdW199swuNwiic9emeccaeytk3kqWy82b4F21pRQo4rUC1hG14VNbemWbF7qNmIuidaA/IETfF1jZ+UTturFaZOLzhTfNo+5e2YDhl/8PsxH+52Lu72oiczyuSUxS+PZ3ZjnFSgA0E0917mBCFV3SeEDzDu6/f1cVQ==
X-YMail-OSG: ZLEfS2sVM1lk0I6iQYW5PaC27I6c61k7i1jV62cC4k.LmLL85pmV5Bd1SzzocJs
 sRfj94Pu4n3wFv1H_bhWjKvopCKSTupX0RCYaDhBaUw4l2N0pSafWoYv1p7Gw8PadYcrpqeTJkmo
 x.vFg3ICrxKeHJe5A2VjBgVUEF_eugMhyT2Kzqr946MYTvBF0X25MXIHn.W6.2gGmuFxfVNfaJbk
 wf1cvUYnRTlz9VbmQ8jqsBWcWWybpFhhWarQb6ys_3OK4WNIHvOc4acXtDGYtFUo9mGbPDdixfii
 .HyxC5mNMUnl7mF5dDGXJk.NzpSa9FZzkes7m9A7H764xLIzf5hXzgHq73Dw8qQTc6ZysClNsbE7
 Cqg9zJzR_MaVhtU0.wAbKgwJzQHR1iJ55jaOcg0byMOZ0uoQBJAH6TuYXoONFmR8od58M32mpPWr
 kURn0vEpDgo6ziJSLwNCffWjfg29YmK5biUHIxwVkaZMtJMwypJqiKONdSszFXqeKZfkZ43yMVzk
 NPsOGpF.B8McUrusJ8bU8V5_Pw64P2MzyRG_xOqHU4PEVJ8QcHSUKutvC17bM3hlbXN2URZlENMd
 d8Vf1DHE0kXtkkPZ4VOiSoIDBZgLuWkasmiahU4upu6la7rTzo9lzmbxZtBgCASkn1ZknrsBuanq
 s4gwFJJjx5JRJ0M1OfPm.ljypeTz2C8k.2sDFGlFcZsVpIqoi40CLTwWZeDTLPR4EziHpb3AWhiQ
 Wny4DBpwdRD7gPOjsiGO6w9OZAtrGiJd3daH7ELv6V9EsinNln6wYjpf.P03ZtSSeGVjLpj3gwC5
 4ZQ6xDPuavzeSH5cPOYSWdDTfO.IUhjmAJhRjKlmSu6B5Wa6rtLrtlScqypRMQAKGuAV8YduU5KI
 8eYtkpmUVzCmZgEhtfKGxS2GYC7jxikiAGdV2ElykH1jwQOXG9_6MJeHgM_S7wG.sIVzW5BvY46S
 U3gM0PK5AVuKU8r8W4jpC5_MOIUbRM1UFWE9AR4pGtumwfhniOhER3TyiCVZI2xKHrkD432P83Gd
 mZN3fPspYLogkNTC4Pp5BnehwQnuS7.Q1LEDG7K4yXIHWEWw5JIZ46YoZm5pXFYVnPVa0w84MN_.
 8ErDK4fqws8tDW_ASdgJBiWOupx35rpfu.rPF2224lydresvTjLnTIf8lFnhXN7BgaLoaBZcuELo
 7d7.6T.VinNDGuXqbdmE_ducuAYaeJ7cmmW3_ZpH5nIJXxXTPL1SLIUhl1cz6mcX_baEL4kuRe7G
 QBHv3bahyaZqtCrIWnR0n7wmtRNy2FEYSnHq3oUlt19LRQgWfoZcQe_GuDMFKfNB5Pxuoy3b4KVt
 CFMHhQXta0y6ZgvoOw5i9EEPCWKsh5_gwAwF5XcK3wkcG3LGE6p37DRvSe3ZA6rk.EbJd2mEQghM
 kIyy4lSay2M49R9IvFN5a5UPkXOLi14eHbk.8BNbLJhtErNaT725b8ay_JaMv_czB0ue.SfOtgpY
 XWyRQdpzwRYjzGhxb6.MNFQCTSQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Apr 2020 07:31:01 +0000
Received: by smtp407.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 98aed6c61d98e300b5dca39559149029; 
 Tue, 21 Apr 2020 07:28:59 +0000 (UTC)
Date: Tue, 21 Apr 2020 15:28:51 +0800
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20200421072839.GA13867@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-20-willy@infradead.org>
 <20200420224210.dff005bc62957a4d81d58226@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200420224210.dff005bc62957a4d81d58226@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15739 hermes Apache-HttpAsyncClient/4.1.4
 (Java/11.0.6)
X-Headers-End: 1jQnN5-008nxR-8X
Subject: Re: [f2fs-dev] [PATCH v11 19/25] erofs: Convert compressed files
 from readpages to readahead
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
From: Gao Xiang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: cluster-devel@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, William Kucharski <william.kucharski@oracle.com>,
 linux-btrfs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Andrew,

On Mon, Apr 20, 2020 at 10:42:10PM -0700, Andrew Morton wrote:
> On Tue, 14 Apr 2020 08:02:27 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > 
> > Use the new readahead operation in erofs.
> > 
> 
> Well this is exciting.
> 
> fs/erofs/data.c: In function erofs_raw_access_readahead:
> fs/erofs/data.c:149:18: warning: last_block may be used uninitialized in this function [-Wmaybe-uninitialized]
> 	*last_block + 1 != current_block) {
> 
> It seems to be a preexisting bug, which your patch prompted gcc-7.2.0
> to notice.
> 
> erofs_read_raw_page() goes in and uses *last_block, but neither of its
> callers has initialized it.  Could the erofs maintainers please take a
> look?

simply because last_block doesn't need to be initialized at first,
because bio == NULL in the begining anyway. I believe this is a gcc
false warning because some gcc versions raised some before (many gccs
don't, including my current gcc (Debian 8.3.0-6) 8.3.0).

in detail,

146         /* note that for readpage case, bio also equals to NULL */
147         if (bio &&
148             /* not continuous */
149             *last_block + 1 != current_block) {
150 submit_bio_retry:
151                 submit_bio(bio);
152                 bio = NULL;
153         }

bio will be NULL and will bypass the next condition at first.
after that,

155         if (!bio) {

...

221                 bio = bio_alloc(GFP_NOIO, nblocks);

...

}

...

230         err = bio_add_page(bio, page, PAGE_SIZE, 0);
231         /* out of the extent or bio is full */
232         if (err < PAGE_SIZE)
233                 goto submit_bio_retry;
234
235         *last_block = current_block;

so bio != NULL, and last_block will be assigned then as well.

Thanks,
Gao Xiang




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
