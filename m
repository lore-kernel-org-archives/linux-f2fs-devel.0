From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 05/11] f2fs: add mount option to select fault
 injection ratio
Date: Mon, 9 May 2016 20:00:13 +0800
Message-ID: <c73659fa-5d48-8fc4-d76d-0ba480bfda48@huawei.com>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
 <1462299708-67906-5-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462299708-67906-5-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/5/4 2:21, Jaegeuk Kim wrote:
> This patch adds a mount option to select fault ratio.

It's better to add description in documentation for this new mount option.

Anyway, this patchset looks good to me, please add:

Acked-by: Chao Yu <yuchao0@huawei.com>
