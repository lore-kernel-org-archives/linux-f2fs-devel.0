Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C69C79FBD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1MITFprKUYvmx+8yxs0xdukbcdHvgGpyVRL0lbmxNEc=; b=knIJrCxSC8lGUnSpDS180JtV/N
	lePTgF4otTIpZtK0zmDfUKv75Fgwz0BgYlal3ZfOnuXClRc6JOY8CRTz/8yhjQdZdZpMQuPeF2vFB
	3LlpXfim5WPfsJ0wuuCXYhUwa7kI0UYNSOFwLoUC0cyrtbO33JwEkSk+PH1byqhm6J74=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4MOZ-00011T-9q;
	Wed, 09 Sep 2026 17:47:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tz2294@columbia.edu>) id 1x4MOX-00011M-5L
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 17:47:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aPEyuOHa2Xf8hImQXcpukM+8uHb3YA7v7XMeWMx3v/U=; b=bUktz8ydWQzgYrAx2JLoavBVOe
 Tc4MIA0yFUMRuKjqP6JFbgSfjWVR6aXSgari2ZUP5RUsPDDh31TAKh8cpuPNG1weoFAry8Zq0A5mc
 QUW5phlA6DldeKQQEzGpReoCTl//OTsQAjH3Si8IU7Wukg82Kq6GUhoNbWiMwiYPuNXE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aPEyuOHa2Xf8hImQXcpukM+8uHb3YA7v7XMeWMx3v/U=; b=dVPlcBNI0cujA8Ci4pqtqtUmy9
 Dc636v9DMUt44jPoPN1pXgE6j4PjI5zYln2aT9EaHLX7tjT733GJd4FFBwGzasJANRDsAa3cQeO1y
 6xBo51aTDAJM+IfAle4tRdmBwMHQMUsg6fMOmc2DfsQezRQXCBJc1KfcCjCVmeo4SKPM=;
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4MOU-0001lS-U7 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 17:47:35 +0000
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689HS4hD993575
 for <linux-f2fs-devel@lists.sourceforge.net>; Wed, 9 Sep 2026 13:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=aPEy
 uOHa2Xf8hImQXcpukM+8uHb3YA7v7XMeWMx3v/U=; b=DjRQeO6hhGQ6ZYjAObJ5
 /57qcPKnOwj1fymOVEV+nrbxT9iWnT5Bdyg31cdt6boDVmYsyuhwvfKfxvkKfoTD
 Ll4UPjKBfzaaxj0H3M04AdKlciGt0q9P//CcKBoFBtJkdycJZtaE1uqSgMoUW3as
 YCftzjHUlpEKNZyxh7TGR5BLLGwZ4+wGYmqBHBIBbfT8aMwdz2j2KOO6x8aDoZYk
 Gp3amBJ0NYy0AO6OHdFKAKfJd07JJGvH/QUDn79JHP9mL2Fo7UzyARY3hAHRQbMG
 /UXL5xzBCj9b7xfRivTDlni7o0R7ixrTI23YkRlAsEWpzfQb9N54FJxNnWE5tB8N
 BA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gkbsxg7mm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 13:47:29 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90ce21f2cc9so145266436d6.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1788976048; x=1789580848;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aPEyuOHa2Xf8hImQXcpukM+8uHb3YA7v7XMeWMx3v/U=;
 b=3TdBhckF6tp9IzwbiLXKWkv5PCh7XTX2gwXCpiJEAxo9FBfZolK3OdV0Pgt/ppbFA7
 qvGS/lG8oHsfBSaJPLeqYG1xUEn9zuN2/ghCnshDeOOjflQ2THHadXkBpeK8n3Mx+jFI
 vzGiqs0TB1OVV6XT/d/C24SKGRhkpMb7lNz7wL4kynkhR/20ffO0fFIFxXLiHLqbDkHY
 XMC3nlpEzZIOar8YlpLmfRcBW5wJeOycM09tsZwgM6/VYMFyojQ0aRnXjyrFL8iwNAtS
 05OUNwvtIapHhqZpQ7GU2eLZ713yE2S84ogmQChoxJ8hNZKzANmvku1eQ+hwOfqgkPCz
 RuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788976048; x=1789580848;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aPEyuOHa2Xf8hImQXcpukM+8uHb3YA7v7XMeWMx3v/U=;
 b=eSH+sDwD5ewn9fwHHnYu/hHPAHlibEjOmv1YQiiubk3wylaW3lmSBxFz09QottAYx8
 xpzt+0b7sOrYspWffRTkf4Uy5DzATkSye04KVR6dPESZ4/ZceuLEqLJUvPw8+/UiJNGW
 L9Z4LsO3A0OTkJzFkFlxhVS9eKN6O1+XyYwPo02p6WV3Atj+wOrSLDA3L1Qiso4qOKWy
 DyYwoQosWPjFV/fCzvYvn4Wy2FysyJ/utoW5gqfuCt1UNN2hw+IQXtqYR7Ih0Ltec7Qr
 0SyWeaf4Tz1GwBJITV9PpYhuz170aH9bsFpAKksL0eC8mEOHFypnMutbqKqsH//Id1YW
 /YXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7H+oyNDDG1pM1fyAd0fS+V836egO8lgaRxaATqu8BHK+oci1/8+pM4EcRtFfCL7UhS0Wa60L0apAdK0MbarYG@lists.sourceforge.net
X-Gm-Message-State: AFuF++lLs9V/MgACd2EFbJOkdjJXaql/3JvVJf18E5J1UvFQQucflD+8
 ESRhmTDaP4OGJredra6zCavFlXHXlcFPfs+Xt4OgabjIeSuu9nvW9GKtCSid7wBWpTGE6f9ysDN
 HZlDIhPkehTpxWOwjzIu1FMpHygQcl0wjqxUuqhh/3oaI0cZmZgiDDkOL2C4JF3unH5evco9fMt
 U=
X-Gm-Gg: AYBFou3t5cZBbCWdR9QXN3bfACzpYX4biEVhGTQZx2ZsQhbH9n+UWUrRJwskn9FTsjb
 EmJ/S+PLMZLhXuXJHZH8r0+YTgcqpsmMJe4Ob2DiFXg5fD+08RM3TQ84d5Eyq661dJHAYXJWxhO
 jdjcYncrp7TRMGWedPl9eSNUsRbr8KpPoGFCw+uRRj+wobjPajLTzpGPxfA7KdWV+aUVeuj28Qs
 ejYQHp7JLqH/K8dheDqe0mBYbfoSmd2KURv/kV38+0UipZxv0nDEmSSyW7TcDmJpRkSMmS1bUHV
 lfDzCXyjyfnDrLQAfrLKXgNSYstfLdcjeKka1ds5IeYL7wvLEQl4UV9jqmz77JBXofc0S92VYIh
 P1RlXgxxg5UscMr4PpT6X/CCCn/Bo/7pPWX8nBapOoQqbnQyLRhvj
X-Received: by 2002:a05:6214:5297:b0:910:345a:8bd2 with SMTP id
 6a1803df08f44-9103f07142emr449128236d6.35.1788976047943; 
 Wed, 09 Sep 2026 10:47:27 -0700 (PDT)
X-Received: by 2002:a05:6214:5297:b0:910:345a:8bd2 with SMTP id
 6a1803df08f44-9103f07142emr449127266d6.35.1788976047298; 
 Wed, 09 Sep 2026 10:47:27 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-176-193.net.columbia.edu.
 [128.59.176.193]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9106412e038sm53426756d6.20.2026.09.09.10.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 10:47:25 -0700 (PDT)
Message-ID: <3dfab5df-c205-4853-bf48-86351a02b4e2@columbia.edu>
Date: Wed, 9 Sep 2026 13:47:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "David Hildenbrand (Arm)" <david@kernel.org>
References: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
 <20260907-remove-pg_private-v3-6-6ae22f9d9272@nvidia.com>
 <e5792e81-e8a5-42e1-aafe-58dc603f4968@kernel.org>
 <178889163877.1334491.3646957026033534678.b4-reply@b4>
 <83a8743b-9cbb-42a5-9ff5-718297916a76@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <83a8743b-9cbb-42a5-9ff5-718297916a76@kernel.org>
X-Authority-Analysis: v=2.4 cv=V9dNF+ni c=1 sm=1 tr=0 ts=6aa19bb1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=VwQbUJbxAAAA:8 a=FP58Ms26AAAA:8 a=Ikd4Dj_1AAAA:8 a=brY8mzgTOjc0s726uLoA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE5NyBTYWx0ZWRfXwj5/dRwwEyFf
 qT1PWIvDQ24QzZo50pRlmu00R896udsP7tdeqj70vVQmW1i/4O8LUJuT4GImG8w2BYc6CVQE57p
 lzm568kAdYXXOg/6XYFS8fiHW0LfATn7bm/euS9nqWonzkYTIdC40V1wejTM09cKflK6IKTv4jv
 /5K0/bUix6xU93gqjEIyfFAbS3ld5d1gNcYZmigo7BiUoCalT+zcR/Ef6ij2VXpCI44GxhQCLnC
 4CPWY6UnLUkbZsP+TgZL6B+vg0pZWQnPBPlF8VDs7qwzCC0WODaq6GfEk30v0FnjCceaaJq49UJ
 xMwQJ5c7+cfnMAbfR4wsoCMvI/ZXSwkZaVnzvw7/7ZvLH23k7NfQ0HWxWDMBv8bc5i6DXZv64EW
 rNtxLI+S7yaC2FrSR1aQVvTHGESVOlT4doEDhhadE/4KyyxnjcTO3LkEzC+w5205Q4TFQOU85tm
 GfxRWKwjfSANL58d86w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE5NyBTYWx0ZWRfXyQm721kH62po
 oXluGjmaTVtFhQxFdyROYsoExgp6PSMKE31xIPbgSEpoxREhr+LBhEx83wY2giPf1f5UX2xfi2E
 lNuHUfqXeD+bdoqAAY73CtH3NmrWTBUcO765hY66WBkHIN00E7je
X-Proofpoint-ORIG-GUID: 3gJYlNGTHblFKy9frRrofwQPHgy3xseH
X-Proofpoint-GUID: 3gJYlNGTHblFKy9frRrofwQPHgy3xseH
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=10
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=10 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090197
X-Headers-End: 1x4MOU-0001lS-U7
Subject: Re: [f2fs-dev] [PATCH v3 06/14] f2fs: stop using PG_private
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
Cc: Michal Hocko <mhocko@suse.com>, "Liam R. Howlett" <liam@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Ying Huang <ying.huang@linux.alibaba.com>,
 Qi Zheng <qi.zheng@linux.dev>, Vlastimil Babka <vbabka@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Dev Jain <dev.jain@arm.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
 Gregory Price <gourry@gourry.net>, Ryan Roberts <ryan.roberts@arm.com>,
 Usama Arif <usama.arif@linux.dev>, linux-f2fs-devel@lists.sourceforge.net,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Barry Song <baohua@kernel.org>,
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
 Nico Pache <nico.pache@linux.dev>, Lance Yang <lance.yang@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/9/26 3:48 PM, David Hildenbrand (Arm) wrote:
> On 9/8/26 20:20, Tal Zussman wrote:
>> On 2026-09-08 17:47 +0200, David Hildenbrand (Arm) wrote:
>>> On 9/8/26 04:56, Zi Yan wrote:
>>>> f2fs sets its PAGE_PRIVATE_* flags in page->private and checking
>>>> page->private != NULL is equivalent to checking PG_private. Change
>>>> PagePrivate() to page_private(). Meanwhile, in set_page_private_##name(),
>>>> page->private is first set to 0/NULL before an PAGE_PRIVATE_* flag is set,
>>>> but it can cause confusion when PG_private is removed and
>>>> page->private != NULL is used instead. Change it to initialize
>>>> page->private to PAGE_PRIVATE_NOT_POINTER instead and retain the original
>>>> semantics.
>>>>
>>>> It prepares for a future commit that removes PG_private.
>>>>
>>>> No functional change intended.
>>>>
>>>> Assisted-by: Claude:claude-opus-4-8
>>>> Assisted-by: Codex:gpt-5
>>>> To: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> To: Chao Yu <chao@kernel.org>
>>>> Cc: linux-f2fs-devel@lists.sourceforge.net
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Acked-by: Usama Arif <usama.arif@linux.dev>
>>>> Acked-by: Chao Yu <chao@kernel.org>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>  fs/f2fs/f2fs.h | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index 9940a6cecf1a2..2f7ab5888b078 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -2691,7 +2691,7 @@ static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
>>>>  }									\
>>>>  static inline bool page_private_##name(struct page *page) \
>>>>  { \
>>>> -	return PagePrivate(page) && \
>>>> +	return page_private(page) && \
>>>>  		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
>>>>  		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>>>>  }
>>>> @@ -2710,9 +2710,9 @@ static inline void folio_set_f2fs_##name(struct folio *folio)		\
>>>>  }									\
>>>>  static inline void set_page_private_##name(struct page *page) \
>>>>  { \
>>>> -	if (!PagePrivate(page)) \
>>>> -		attach_page_private(page, (void *)0); \
>>>> -	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
>>>> +	if (!page_private(page)) \
>>>> +		attach_page_private(page, \
>>>> +				(void *)BIT(PAGE_PRIVATE_NOT_POINTER)); \
>>>>  	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>>>>  }
>>>
>>> Very weird interface. Why do we even need the page-based interface still?
>>>
>>> $ git grep -E "(set|clear)_page_private"
>>> compress.c:             clear_page_private_gcing(cc->rpages[i]);
>>> compress.c:                     set_page_private_gcing(cc->rpages[i]);
>>> compress.c:             clear_page_private_gcing(cic->rpages[i]);
>>> f2fs.h:static inline void set_page_private_##name(struct page *page) \
>>> f2fs.h:static inline void clear_page_private_##name(struct page *page) \
>>>
>>> Seeing code like:
>>>
>>> clear_page_private_gcing(cc->rpages[i]);
>>> if (folio_test_writeback(page_folio(cc->rpages[i])))
>>> 	end_page_writeback(cc->rpages[i]);
>>>
>>> Makes me wonder whether we can just use the folio helper instead?
>>>
>>> In f2fs_iget(), we enable large folios only when !f2fs_compressed_file(inode).
>>>
>>> So naive me would assume that we can just get rid of the
>>> set_page_private_/clear_page_private_ stuff entirely.
>>>
>> 
>> I have a WIP series of ~30 patches converting much of the remaining page
>> users in f2fs (including the below) to folios. Still have to do some
>> testing and clean it up, but hoping to send it out in the next couple of
>> weeks (in the hopes of eliminating some more folio_compat.c functions by
>> next cycle...)
> 
> Indeed best to wait a bit before flooding -mm even more, it's rather a lot at
> this point.
> 
> In the context of this series, it would be great if you could review whether the
> diff I proposed would get the job done, thanks!
> 

What it changes looks good, but I would go a little further.

There are only two more users of page_private_gcing(), which pass fio->page.
Those could easily be converted to folio_test_f2fs_gcing() by passing fio->folio,
which is in a union with fio->page. That would let you delete the
page_private_##name() implementation in PAGE_PRIVATE_GET_FUNC() as well and just
remove the entire family. At that point PAGE_PRIVATE_{GET,SET,CLEAR}_FUNC()
could be renamed to something like F2FS_FOLIO_PRIVATE_{GET,SET,CLEAR}_FUNC() and
all of this cruft is gone and folio-based, with no more f2fs use of page_private()
either.

The renaming could be done as a later step, but I would get rid of the accessors
as well in one swoop.

> -- 
> Cheers,
> 
> David
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
