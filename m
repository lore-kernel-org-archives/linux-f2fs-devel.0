Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E24FC88E63
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rvCo2nhQ+qLcKgubROm5Jigcd8exrzNwT6NIFPgz/Pk=; b=TgF5z/tTEzQgFvzU4SyBkKIRDJ
	5VQEqOlcGYOyGb/nC8Ce6/7Fm5hQM0Nf5D+dvRDlHwLbWy27qFsXfE4CEdZAw+EBVAqzuWvNSJYZS
	hBJ81Oxv3wg7tfZ4XRhxYBk34psOJo0Q+/ZDY/1u7WL5f+VGH/b+WKnQpBQ4tle3fiXM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x5qvL-0001qS-S0;
	Sun, 13 Sep 2026 20:35:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tz2294@columbia.edu>) id 1x5qvJ-0001qK-4J
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 20:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xmmCbWeNjsNg9Gzck7tgmssf89nltQI5HT0F64h0084=; b=lF7YiU3TTeK6wsVEElTGm2R+N+
 nmAjeyi7uL6SaTKrm0OM6mzLEaXVZ1kV2kWbMJ+b//82ftpTXo2UzUyaZbefMN/Gwleud2Nj5d2Mw
 Nb5SgWpnfePuZ2Bq+pET6Rpxk0njTHw/OxYwv5OW5/R3QuhsV32GOPgt0+ntl4QK+RQg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xmmCbWeNjsNg9Gzck7tgmssf89nltQI5HT0F64h0084=; b=KdZlmMGn1ZvqhZPMs4shCHkWdL
 Vyr3FlvSaNHx8aX7N/G8M9e+9lj453ic0X/bNLvHoNSTrWkPS26pKAimNpaJWDZUJFHiHwTjfaIK1
 TwOe11HG2AfrftnLLYtbEtfJZL+nkt7pj7PhWOqbDbi4+XrFtAG1q1SZWDZCINPjgijs=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5qvE-0002Ni-V6 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 20:35:34 +0000
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DIXarL311466
 for <linux-f2fs-devel@lists.sourceforge.net>; Sun, 13 Sep 2026 16:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=xmmC
 bWeNjsNg9Gzck7tgmssf89nltQI5HT0F64h0084=; b=meP7My1qraBPv99/dAct
 c/kxivRvRltxw9A6To/cOqKHpDAm+YNr566ZKHQ1Fg6VDfO1lg22RQflyrXDDfLA
 a1HBRKgeUcVtf0UlvgPz328n8zl1aG9fa9SycosDvXclEvReC8w3YnfW8hEBx0my
 Rm7pH1UbInIC7q30KWdnKhymAimiiRlj0m1+5ePEijhir0Fi6FEi7Ixun692MifM
 n0BWUdTH7UpQ++WYr8OVkt/V0i2ppih16ZjGfZ7Mh4pL1BS33j6YahRVevB4tmVB
 RBSNITLU9JDlP6kV8GL5j15Yfe8yKdJUcGPB2hhHAKMSa78Hk99bB7C8QlNAcCKo
 3A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gn0ap79eq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 16:11:06 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a1bffc2eeso148523185a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1789330266; x=1789935066;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xmmCbWeNjsNg9Gzck7tgmssf89nltQI5HT0F64h0084=;
 b=3njCfKq+NKRoedptVGOmQ0b6fijtWTjB5+Fk5p6muayp3kuRZ/otJ2mpDliZXZ+M/n
 GnvfzO8UAFSC9sH+swauLycpcKbKOwvdQS+dHkF83C1w2wXd2W8VXAXTQJ1fJhyZeeuW
 JDvSGpyx73lTg//FRSJBsUAVPDXPtLO3RFDQbu1HhzmucNEZhAflYleAzYmf5pxL6AXh
 x2Fdh2tntFSpDn2WUiw50jJ1pQl2ZV6YZ+ieSCf0OjYx6pAHW5CuxfmMaI5K21uQRS9T
 ukLBgzjLm5PpH+RpYGFLxVjqD7T2cO9KwsReEp5ACEpj2ADlVcJUaX+0SuV2SkFA4T1q
 o31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789330266; x=1789935066;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xmmCbWeNjsNg9Gzck7tgmssf89nltQI5HT0F64h0084=;
 b=nlye3DBm11rSmcEQ3oqAwevjeXygvq2MUjBKmcTTJeE4ua7R5P2ovm1+0yiJ9LYGcQ
 yh7h93FSoqQr8RZMwlQTVRdMxCMMgpBTjUiyiwvE9/eVK6GaO64oQQigeFPu9pLk9rW8
 kA/iftDdcYvdn6yoMM7D0ae/BO9BFqdTmfTxGNjz/KVtTMDpIaH3OMzAtcNTmsjIrLAj
 F5Tenn9xyA84HVu+bFBBivSwIVBtHt+L62lZt0rEJn0UFmE5OkR3w+iBBfHmTy/Gd/Iu
 Ow7KTjZMr9PZdhFBEjej8/NDl2guhbusbpNDRn0X66qgY3igZHPM9zHbsd5NPz7E1sGk
 nXlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw70fW2kghN3ENB9QNBu1Gn0Tcx7a/W09dslCrCUZRp2yFVYopKksKuEHbAq6xbj1rSh58G1w46dqXOcESzfgTp@lists.sourceforge.net
X-Gm-Message-State: AFuF++k/FS0zhGPRRxQWLp85PeoyXN3KRadl2KfO/VCiMB7n9ogNFB1Y
 6r/GmEpBgByPTC63m4iBua0OUWZNO+V2+Id8Qj44eOlWyevLlzwICZOeJh6InWZ8P/wvjfC7gNR
 d3NLZS6hV/eIhTzzHWb5KJcXm/5/h0q4BRVYHCR32ALTGfVYEfQXd1uVfpUZI4H66JZguivmVto
 E=
X-Gm-Gg: AYBFou0F4IqeSrc+ELsuOnr1LJRgg5rP0I0tYnW0kTkas8RVeo/EaKIxEqpOTLGliOo
 mzeqxBaZsp3Y4Xb1Pw1o1j7f6EqGyX1hX18Wa0AC4rOPVl+BAv1fYKMo6/YtwxDi3L0mRPRPxfj
 x9EbQubQYsVbhfes5TUS4pSIVMixP+Ld21WAO0exsQw8jLvAHnNLUuOg3FFXFKzLsLtMIcYIxbY
 kbwJNhDqcM4Zcsqm1B6x5rG/kpBnHbe32sJDi5rY2yMj/4GGc6KQpBCFGBDghzXnD1AMdbmGtbK
 bzWrX/o+U3vKXZQhl1CUOWrw0fql5dtNyrk1v/J5BvonyB+fv/83Cmc9vpqB008axOTU27gkzC/
 219aAK8wFYZlGKFknxEYWEW9Qi0G5JvrX8rzrxq1+jscrE+nTBeuS
X-Received: by 2002:a05:620a:4443:b0:936:eeab:307e with SMTP id
 af79cd13be357-93a0357e40fmr1139530885a.9.1789330265911; 
 Sun, 13 Sep 2026 13:11:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4443:b0:936:eeab:307e with SMTP id
 af79cd13be357-93a0357e40fmr1139526085a.9.1789330265446; 
 Sun, 13 Sep 2026 13:11:05 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-179-215.net.columbia.edu.
 [128.59.179.215]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939f592c482sm659587485a.3.2026.09.13.13.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 13:11:04 -0700 (PDT)
Message-ID: <f971be6c-c3e8-42ad-ae4b-fb3d0753a8c2@columbia.edu>
Date: Sun, 13 Sep 2026 16:11:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zi Yan <ziy@nvidia.com>, "David Hildenbrand (Arm)" <david@kernel.org>
References: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
 <20260907-remove-pg_private-v3-6-6ae22f9d9272@nvidia.com>
 <e5792e81-e8a5-42e1-aafe-58dc603f4968@kernel.org>
 <178889163877.1334491.3646957026033534678.b4-reply@b4>
 <83a8743b-9cbb-42a5-9ff5-718297916a76@kernel.org>
 <3dfab5df-c205-4853-bf48-86351a02b4e2@columbia.edu>
 <927c0ec3-4183-4355-9269-721d79f4983c@kernel.org>
 <30DEBE66-9E26-4468-9A12-123539ED68A3@nvidia.com>
 <DLBY1EIZD8G9.3O0LMDKCMNPIB@nvidia.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <DLBY1EIZD8G9.3O0LMDKCMNPIB@nvidia.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI4NiBTYWx0ZWRfX7m2+NRTe5aMo
 jPCMlM18pTcHbAetI3ycjN+yn4tUnFpifi/rM5APZQ0wzAzW87zyJwFqAOSJA5tvPGUjAezrC8N
 lCAj4xsplrUFDFuE8BPzAH+zhqH1tktixEH36+Oh1nNHdR93khxD
X-Proofpoint-GUID: S2A2W7QoDDWvMKmRkxDXBvMu4gTsYHWW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI4NiBTYWx0ZWRfX5L4E/NPkpzbK
 5owE5D/U50+dTxM3mE+ETh1YqBeVS93aCIme712psO5HlxhgLk0bHUPXgWpY5MpUXkWQhzUCwkg
 XsSl3aliOE7E1p1sVnUOzlkkx+Yu+YBUeWy99NThpDiUy5ZlXbBzNT4PV+Z+EP89/pdu3agLmtC
 puYGSaCV5edLtiazyYbVFr4pcxZ1YXoaXj0gxUQNuphSUNqYh1bCMkwq78rcD6O57yPuVUYSp6z
 9pHH+E5ewHdPk1TwIneAjP1/woFiXqkec/8g4Pzr5bD5P8J3i/od6KUA8firbMiTezblYC+lDXV
 v8jRyy4ttPkJJyxn4ymdedN15DW15MF0gGalfox69aX5LbR/VbFne9V6jjnPaDrKLrVexSp9vkt
 qY7ZV3d68tceyJsgrOBJRQe2eUsF4SN+1NYyYmQQS8zxFAo8FVJSyHs+EL1uwBgTeqQ/rImk4J0
 zVl+EzjuYa1Yi1hswYg==
X-Proofpoint-ORIG-GUID: S2A2W7QoDDWvMKmRkxDXBvMu4gTsYHWW
X-Authority-Analysis: v=2.4 cv=NJxAaE6g c=1 sm=1 tr=0 ts=6aa7035a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=2jelXx5xVcRIF5zNctN5Qg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=FP58Ms26AAAA:8 a=3Zgl-KUdFkos_lAptz8A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11904
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 spamscore=0 phishscore=0 bulkscore=10 impostorscore=10
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130286
X-Headers-End: 1x5qvE-0002Ni-V6
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
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
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

On 9/10/26 5:11 PM, Zi Yan wrote:
> OK, here is the patch. In addition to David's patch and Tal' suggestion,
> I also
> 1. converted PAGE_PRIVATE_* flags to F2FS_FOLIO_PRIVATE_*,
> 2. converted page/folio union in f2fs_io_info to folio only, since no
> one is using fio->page any more.
> 

Nice!

> Let me know your feedback. I will add this to my patch series once you
> are OK with it. Thanks.
> 
>  From 3bae5c494459b3dd05893df6051e3eb37164f810 Mon Sep 17 00:00:00 2001
> From: Zi Yan <ziy@nvidia.com>
> Date: Thu, 10 Sep 2026 16:42:39 -0400
> Subject: [PATCH] f2fs: convert the ->private flag helpers to folio-only
> 
> page-based ->private flag helpers are used in the compression path, where
> large folios are not enabled. They can use folio versions with
> page_folio(). The two remaining users in data.c and segment.c can use
> fio->folio instead of fio->page (two are in a union).
> 
> Drop page-based helpers after the conversion and rename
> PAGE_PRIVATE_{GET,SET,CLEAR}_FUNC() and the PAGE_PRIVATE_* flags to
> F2FS_FOLIO_PRIVATE_* to match. Convert the folio/page union from
> f2fs_io_info union to folio only, since no page user is left.
> 
> The folio helpers do a plain read-modify-write where the page ones used
> set_bit()/clear_bit(). It is fine because the converted code either holds
> folio lock or, in f2fs_compress_write_end_io(), matches what the
> non-compressed code does in f2fs_write_end_bio().
> 
> Assisted-by: Claude:claude-opus-5
> Suggested-by: Tal Zussman <tz2294@columbia.edu>
> Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> To: Jaegeuk Kim <jaegeuk@kernel.org>
> To: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org

Looks good, so:

Reviewed-by: Tal Zussman <tz2294@columbia.edu>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
