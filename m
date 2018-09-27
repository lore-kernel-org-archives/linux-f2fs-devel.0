From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 2/2 v3] f2fs: avoid f2fs_bug_on if
 f2fs_get_meta_page_nofail got EIO
Date: Thu, 27 Sep 2018 20:09:57 +0800
Message-ID: <0c036757-5200-e952-e814-d07aa50af90f@kernel.org>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
 <20180918021805.85032-2-jaegeuk@kernel.org>
 <20180918175648.GE91945@jaegeuk-macbookpro.roam.corp.google.com>
 <20180920214804.GF35918@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920214804.GF35918@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018-9-21 5:48, Jaegeuk Kim wrote:
> This patch avoids BUG_ON when f2fs_get_meta_page_nofail got EIO during
> xfstests/generic/475.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
