From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: don't use GFP_ZERO for page caches
Date: Tue, 10 Apr 2018 14:36:53 +0800
Message-ID: <36393b5a-9b99-4304-c077-09288219dfad@huawei.com>
References: <20180409190012.21552-1-jaegeuk@kernel.org>
 <fc31dd88-5dbb-1c37-28fe-dfef09cc448c@huawei.com>
 <20180410035022.GB47598@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180410035022.GB47598@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/4/10 11:50, Jaegeuk Kim wrote:
> Actually, we don't need to do this, since fill_node_footer(true) will reset the
> page.

Yes, confirmed.

Thanks,
